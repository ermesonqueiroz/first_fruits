import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? bottom;

  const CardWidget({
    super.key,
    required this.title,
    required this.description,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 34, 34, 34),
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: 140,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Color.fromARGB(255, 236, 236, 236)),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            if (bottom != null)
              Text(
                bottom!,
                style: TextStyle(
                  color: Color.fromARGB(255, 236, 236, 236),
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
