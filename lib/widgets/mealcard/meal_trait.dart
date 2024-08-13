import 'package:flutter/material.dart';

class MealTrait extends StatelessWidget {
  const MealTrait({super.key, required this.icon, required this.lebel});
  final IconData icon;
  final String lebel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          lebel,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
