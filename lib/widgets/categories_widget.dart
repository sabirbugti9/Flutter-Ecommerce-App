import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;

  const CategoriesWidget({
    super.key,
    required this.icon,
    required this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.red.shade500 : Colors.black,
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
              fontSize: 13,
              color: isSelected ? Colors.red.shade500 : Colors.black),
        ),
      ],
    );
  }
}
