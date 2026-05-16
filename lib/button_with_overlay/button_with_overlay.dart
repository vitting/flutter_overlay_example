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
  bool _closedByTapOutside = false;
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

    ButtonWithOverlayManager().addListener((isOpen) {
      // debugPrint('Overlay is ${isOpen ? 'open' : 'closed'}');
    });
  }

  @override
  void dispose() {
    ButtonWithOverlayManager().removeListener();
    super.dispose();
  }

  void onTap() {
    if (_closedByTapOutside) {
      setState(() {
        // Consume the same tap sequence that already closed the overlay.
        _closedByTapOutside = false;
        _isOpen = false;
      });
      return;
    }

    setState(() {
      if (_overlayController.isShowing) {
        ButtonWithOverlayManager().closeOverlay(_overlayController);
        _isOpen = false;
        return;
      }

      ButtonWithOverlayManager().openOverlay(_overlayController);
      _overlayController.show();
      _isOpen = true;
    });
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
              behavior: HitTestBehavior.deferToChild,
              onTapOutside: (event) {
                if (_overlayController.isShowing) {
                  setState(() {
                    ButtonWithOverlayManager().closeOverlay(_overlayController);
                    _closedByTapOutside = _isTapOnButton(event.position);
                    _isOpen = false;
                  });
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
