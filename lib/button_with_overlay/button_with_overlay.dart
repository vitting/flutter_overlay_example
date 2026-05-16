import 'package:flutter/material.dart';
import 'package:flutter_overlay_example/button_with_overlay/button_with_overlay_button.dart';
import 'package:flutter_overlay_example/button_with_overlay/button_with_overlay_manager.dart';
import 'package:flutter_overlay_example/button_with_overlay/button_with_overlay_menu.dart';

class ButtonWithOverlay extends StatefulWidget {
  final Widget menuChild;
  final String label;
  final OverlayPortalController? overlayController;

  const ButtonWithOverlay({super.key, required this.label, required this.menuChild, this.overlayController});

  @override
  State<StatefulWidget> createState() => ButtonWithOverlayState();
}

class ButtonWithOverlayState extends State<ButtonWithOverlay> {
  final _buttonKey = GlobalKey();
  bool _isOpen = false;
  final _link = LayerLink();
  late final OverlayPortalController _overlayController;

  @override
  void initState() {
    super.initState();
    if (widget.overlayController != null) {
      _overlayController = widget.overlayController!;
    } else {
      _overlayController = OverlayPortalController();
    }

    ButtonWithOverlayManager().addListener(_overlayController, (isOpen) {
      if (mounted) {
        debugPrint('Overlay state changed: isOpen = $isOpen');
        setState(() {
          _isOpen = isOpen;
        });
      }
    });
  }

  @override
  void dispose() {
    ButtonWithOverlayManager().removeListener(_overlayController);
    super.dispose();
  }

  void onTap() {
    if (_overlayController.isShowing) {
      ButtonWithOverlayManager().closeOverlay(_overlayController);
    } else {
      ButtonWithOverlayManager().openOverlay(_overlayController);
    }
  }

  // Check if the tap was on the button itself to prevent closing the overlay when tapping the button again
  bool _isTapOnButton(Offset globalPosition) {
    final BuildContext? buttonContext = _buttonKey.currentContext;
    if (buttonContext == null) {
      return false;
    }

    final RenderObject? renderObject = buttonContext.findRenderObject();
    if (renderObject is! RenderBox) {
      return false;
    }

    final Offset topLeft = renderObject.localToGlobal(Offset.zero);
    final Rect buttonRect = topLeft & renderObject.size;
    return buttonRect.contains(globalPosition);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (BuildContext context) {
          return CompositedTransformFollower(
            link: _link,
            targetAnchor: Alignment.bottomLeft,
            child: TapRegion(
              onTapOutside: (event) {
                if (_overlayController.isShowing && !_isTapOnButton(event.position)) {
                  ButtonWithOverlayManager().closeOverlay(_overlayController);
                }
              },
              onTapInside: (event) {
                // Prevent the tap from closing the overlay when tapping inside
              },
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ButtonWithOverlayMenu(buttonKey: _buttonKey, child: widget.menuChild),
                ),
              ),
            ),
          );
        },
        child: SizedBox(
          key: _buttonKey,
          child: ButtonWithOverlayButton(isButtonOpen: _isOpen, onTap: onTap, label: widget.label),
        ),
      ),
    );
  }
}
