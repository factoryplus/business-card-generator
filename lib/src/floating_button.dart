import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool showIcon;
  final double? shareButtonFontSize;

  FloatingButton({
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.showIcon = true,
    this.shareButtonFontSize
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () {
          onPressed();
        },
        label: Text(
          title,
          style: TextStyle(
            fontSize: shareButtonFontSize ?? 20.0,
            color: foregroundColor ?? Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: showIcon
            ? Icon(
          Icons.share,
          color: foregroundColor ?? Colors.white,
          size: 20,
        )
            : null,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      ),
    );
  }
}