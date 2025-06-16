import 'package:flutter/material.dart';

class HomeButtonBar extends StatelessWidget
{
  const HomeButtonBar({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      padding: const EdgeInsets.symmetric(horizontal: 100),
      height: 80,
      decoration: BoxDecoration
      (
          color: const Color(0xFF212325),
          boxShadow:
          [
            BoxShadow
            (
              color: Colors.black.withOpacity(0.9),
              spreadRadius: 1,
              blurRadius: 8,
            )
          ]
      ),
      child: Row
      (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          Icon
          (
            Icons.alarm_add,
            color: Colors.green.shade400,
            size: 35,
          ),
          Icon
          (
            Icons.people,
            color: Colors.green.shade400,
            size: 35,
          ),
        ],
      ),
    );
  }
}
