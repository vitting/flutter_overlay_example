import 'package:flutter/material.dart';

class ButtonWithOverlayButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isButtonOpen;

  const ButtonWithOverlayButton({super.key, this.onTap, required this.label, this.isButtonOpen = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.grey),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label),
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: isButtonOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(Icons.arrow_drop_down, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
