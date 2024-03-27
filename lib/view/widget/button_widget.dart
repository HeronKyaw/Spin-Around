import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Color? buttonColor;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final Widget child;
  final bool border;

  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width = double.infinity,
    this.height = 48.0,
    this.buttonColor = const Color(0xFFCD853F),
    this.gradient,
    this.border = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(10);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1.0),
          )
        ],
        border: border ? Border.all(color: Colors.black54) : null,
        borderRadius: borderRadius,
        color: buttonColor,
        gradient: gradient,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
