import 'package:business_card_generator/src/Data/Asset.dart';
import 'package:business_card_generator/src/size_of_widget.dart';
import 'package:business_card_generator/src/structure/super_structure.dart';
import 'package:flutter/material.dart';

class StackTypeGeneral extends SuperStructure{
  final String username;
  final String industry;
  final String? email;
  final String? address;
  final String image;
  final String contactNumber;

  final GlobalKey globalKey;

  StackTypeGeneral(this.image, this.globalKey, this.username, this.contactNumber,this.address,this.email,this.industry):super(image,globalKey);

  @override
  _StackTypeGeneralState createState() => _StackTypeGeneralState();
}

class _StackTypeGeneralState extends State<StackTypeGeneral> {
  ValueNotifier<double> imageWidth = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.globalKey,
      child:  Stack(
        children: [
          SizeOffsetWrapper(
            onSizeChange: (Size size) {
              imageWidth.value = size.width;
            },
            child: Container(
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image:  AssetImage(
                      widget.image,
                      package: 'business_card_generator',
                      //height: MediaQuery.of(context).size.height * 0.27,
                    ),
                    fit: BoxFit.fitHeight,
                  )
               ),
             ),
          ),
          _emaildetails(),
          _industrywidget(),
          _phonedetails(),
          _userdetails(),
          _factoryPlus(),
          _addressdetails(),
        ],
      ),
    );
  }
  Widget _rowTileContainingInfo(widgetType,iconType){
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconType,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 8,),
        Container(
          child: widgetType,
        )
      ],
    );
  }

  Widget _emaildetails() {
    return widget.email!=null ?ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          child: Container(
            child:_rowTileContainingInfo(_emailWidget(), Icons.email),
          ),
          //
          left: MediaQuery.of(context).size.height *0.27 * 0.29,
          top: MediaQuery.of(context).size.height * 0.74 * 0.22,
        );
      },
    ):Container();
  }

  Widget _phonedetails() {
    return ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          child: Container(
            child:_rowTileContainingInfo(_contactWidget(), Icons.call),
          ),
          left: MediaQuery.of(context).size.height *0.30 * 0.74,
          top: MediaQuery.of(context).size.height * 0.21 * 0.10,
        );
      },
    );
  }

  Widget _userdetails() {
    return ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          child: Container(
            child:_rowTileContainingInfo(_userWidget(), Icons.person),
          ),
          top: MediaQuery.of(context).size.height * 0.21 * 0.10,
          left: MediaQuery.of(context).size.height *0.10 * 0.15,
        );
      },
    );
  }

  Widget _addressdetails() {
    return widget.address!=null ? ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          child: Container(
            child:_rowTileContainingInfo(_addressWidget(), Icons.home),
          ),
          left: MediaQuery.of(context).size.height *0.22 * 0.29,
          top: MediaQuery.of(context).size.height * 0.54 * 0.27,
        );
      },
    ):Container();
  }

  Widget _contactWidget() {
    return  Text(
      widget.contactNumber,
      style: const TextStyle(
          fontSize: 13.0,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _emailWidget() {
    return  Text(
      widget.email??'',
      style: const TextStyle(
          fontSize: 10.0,
          color: Colors.white70,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _userWidget() {
    return  Text(
      widget.username,
      style:const TextStyle(
          fontSize: 13.0,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _industrywidget() {
    return ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.21 * 0.45,
          width: imageWidth.value,
          child:  Padding(
            padding:const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.industry,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }


  Widget _addressWidget() {
    return  Text(
      widget.address?? '',
      style: const TextStyle(
          fontSize: 13.0,
          color: Colors.white70,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _factoryPlus() {
    return ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          child: Container(
            child:_rowTileForFactoryPlus(),
          ),
          width: imageWidth.value,
          left: MediaQuery.of(context).size.height *0.29 * 0.25,
          top: MediaQuery.of(context).size.height * 0.27 * 0.86,
        );
      },
    );
  }
  Widget _rowTileForFactoryPlus(){
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 8,),
        const Text(
          'Powered By  ',
          style: TextStyle(
            color:Colors.white70 ,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        Image.asset(
          Assets.app_Logo,
          package: 'business_card_generator',
          height: 18,
          color: Colors.white,),
      ],
    );
  }
}

