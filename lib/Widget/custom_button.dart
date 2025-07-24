import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String? buttonContent;
  VoidCallback? onTap;
  CustomButton({super.key, this.buttonContent, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        height: 50,
        width: double.infinity,
        child: Center(
            child: Text(
          '$buttonContent',
          style: const TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 15, 68, 94)),
        )),
      ),
    );
  }
}
