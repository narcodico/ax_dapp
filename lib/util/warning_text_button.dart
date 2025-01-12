import 'package:flutter/material.dart';

class WarningTextButton extends StatelessWidget {
  const WarningTextButton({
    required this.warningTitle,
    super.key,
  });

  final String warningTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        onPressed: null,
        child: Text(
          warningTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
