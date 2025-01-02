import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, this.onPressed});
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 130,
        height: 50,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Warna biru untuk latar belakang
          ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )));
  }
}