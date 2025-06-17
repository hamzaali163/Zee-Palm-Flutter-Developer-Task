import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color color;
  final Color textColor;
  final double height;
  final double width;
  final double borderRadius;

  const RoundButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.height = 50,
    this.width = double.infinity,
    this.borderRadius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
              )
            : Text(
                title,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
