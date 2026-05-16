import 'package:flutter/material.dart';

class ButtonWithOverlayMenu extends StatelessWidget {
  final Widget child;
  final GlobalKey? buttonKey;
  const ButtonWithOverlayMenu({super.key, required this.child, this.buttonKey});

  double _calculateAvailableHeight(BuildContext context) {
    // If no key provided, use default
    if (buttonKey == null) {
      return 400;
    }

    try {
      final RenderBox? buttonRender = buttonKey!.currentContext?.findRenderObject() as RenderBox?;

      if (buttonRender == null) {
        return 400;
      }

      // Get button position relative to the screen
      final buttonPosition = buttonRender.localToGlobal(Offset.zero);
      final buttonHeight = buttonRender.size.height;
      final screenHeight = MediaQuery.of(context).size.height;

      // Calculate space from bottom of button to bottom of screen
      final availableHeight = screenHeight - (buttonPosition.dy + buttonHeight) - 20;

      // Minimum 150px, no maximum limit
      return availableHeight.clamp(150, double.infinity);
    } catch (e) {
      return 400; // Fallback if error occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PhysicalModel(
        color: Colors.transparent,
        shadowColor: Colors.black26,
        elevation: 9,
        borderRadius: BorderRadius.circular(8),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 150, maxWidth: 250, maxHeight: _calculateAvailableHeight(context)),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.grey),
              ),
              // shadows: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
