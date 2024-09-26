import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).elevatedButtonTheme.style ?? ElevatedButton.styleFrom();

    ButtonStyle style;

    switch (type) {
      case ButtonType.primary:
        style = baseStyle.copyWith(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        );
        break;
      case ButtonType.secondary:
        style = baseStyle.copyWith(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        );
        break;
      // Resto de los casos...
      default:
        style = baseStyle;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Text(text),
    );
  }
}


enum ButtonType { primary, secondary, accept, cancel, edit }
