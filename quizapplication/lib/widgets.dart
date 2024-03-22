import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  final int index;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool showCorrectAnswer;
  final Function() onSelected;

  OptionItem({
    required this.index,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.showCorrectAnswer,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.transparent;
    if (isSelected) {
      backgroundColor = isCorrect ? Colors.green : Colors.red;
    } else if (showCorrectAnswer) {
      backgroundColor = Colors.green;
    }

    return GestureDetector(
      onTap: onSelected,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              '${String.fromCharCode(65 + index)}.',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                color: isSelected || showCorrectAnswer ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}