import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onPress;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomButton(
      {super.key,
      required this.title,
      this.textColor,
      this.backgroundColor,
      this.onPress, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(textColor ?? Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor ?? Theme.of(context).primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
      onPressed: onPress,
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize
        ),
      ),
    );
  }
}

class CustomRoundButton extends StatelessWidget {
  final String title;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onPress;

  const CustomRoundButton(
      {super.key,
      required this.title,
      this.textColor,
      this.backgroundColor,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 1)),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(backgroundColor ?? Colors.white),
        ),
        onPressed: onPress,
        child: CustomSimpleText(
          text: title,
        ),
      ),
    );
  }
}

class CustomAppbarButton extends StatelessWidget {
  final String title;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onPress;
  final EdgeInsetsGeometry? padding;

  const CustomAppbarButton({
    Key? key,
    required this.title,
    this.textColor,
    this.backgroundColor,
    this.onPress,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(textColor ?? Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          padding ??
              const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20), // Adjust padding values for size
        ),
      ),
      onPressed: onPress,
      child: Text(
        title,
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Function onPressed;
  final Color color;
  final FontStyle? fontStyle;
  final TextAlign? alignment;

  const CustomTextButton(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.onPressed,
      this.color = Colors.black,
      this.fontStyle,
      this.fontWeight,
      this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: TextButton(
        onPressed: () => onPressed(),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color ?? Theme.of(context).textTheme.displayLarge?.color,
              fontWeight: fontWeight ??
                  Theme.of(context).textTheme.displayLarge?.fontWeight,
              fontSize:
                  fontSize ?? Theme.of(context).textTheme.displayLarge?.fontSize,
              fontStyle: fontStyle ??
                  Theme.of(context).textTheme.displayLarge?.fontStyle),
        ),
      ),
    );
  }
}
