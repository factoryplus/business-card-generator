import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:business_card_generator/src/Data/total_card.dart';
import 'package:business_card_generator/src/structure/super_structure.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';

class BusinessCardGenerator extends StatefulWidget {
  final String userName;
  final String? address;
  final String? email;
  final String industry;
  final String contactNumber;
   final Widget? shareButton;
   final Color? shareButtonColor;
   final String? shareButtonText;
   final double? shareButtonFontSize;
   final VoidCallback? changeValues;

  const BusinessCardGenerator({
    Key? key,
    this.address,
    required this.userName,
    this.email,
    required this.contactNumber,
    required this.industry,
    this.shareButton,
    this.shareButtonColor,
    this.shareButtonFontSize,
    this.shareButtonText,
    this.changeValues,
  }) : super(key: key);

  @override
  _BusinessCardGeneratorState createState() => _BusinessCardGeneratorState();
}

class _BusinessCardGeneratorState extends State<BusinessCardGenerator> {
  late final TotalCards _totalCardsClass;
  List<Widget> totalCards = List.empty(growable: true);
  int curIndex = 0;
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    _totalCardsClass = TotalCards(widget.userName,widget.contactNumber,widget.address,widget.email,widget.industry);
    totalCards = _totalCardsClass.getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Card'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            _cardsView(),
            _shareButton(),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardsView() {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.27),
      child: PageView.builder(
        itemCount: totalCards.length,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: totalCards[index],
          );
        },
        onPageChanged: (index) {
          _onPageChange(index);
        },
      ),
    );
  }

  Widget _shareButton() {
    return Flexible(
      child: InkWell(
        onTap: () {
          _capturePng((totalCards[curIndex] as SuperStructure).globalKey)
              .then((value) {});
        },
        child: widget.shareButton ?? Container(
                color: widget.shareButtonColor ?? Colors.blue,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.shareButtonText ?? 'Capture & Share',
                  style: TextStyle(fontSize: widget.shareButtonFontSize ?? 20.0),
                ),
              ),
      ),
    );
  }

  _capturePng(GlobalKey _globalKey) async {
    try {
      RenderRepaintBoundary? boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image? image = await boundary?.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image?.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      final directory = (await getExternalStorageDirectory())?.path;
      File imgFile = File('$directory/flutter.png');
      imgFile.writeAsBytesSync(pngBytes!);
      Share.shareFiles(
        ['$directory/flutter.png',],
        sharePositionOrigin:
            boundary!.localToGlobal(Offset.zero) & boundary.size,
      );
    } catch (e) {
      print("debug: $e");
    }
  }

  _onPageChange(int index) {
    setState(() {
      curIndex = index;
      if (index == totalCards.length - 2) {
        for (var value in _totalCardsClass.fetchMoreData(totalCards.length)) {
          totalCards.add(value);
        }
      }
    });
  }
}
