import 'package:flutter/material.dart';

class ButtonWithOverlayManager {
  static final ButtonWithOverlayManager _instance = ButtonWithOverlayManager._internal();

  factory ButtonWithOverlayManager() {
    return _instance;
  }

  ButtonWithOverlayManager._internal();

  OverlayPortalController? _currentController;
  final Map<OverlayPortalController, Function(bool isCurrentButtonOpen)> _listeners = {};

  /// Add a listener for overlay open/close state changes
  void addListener(OverlayPortalController controller, Function(bool isCurrentButtonOpen) listener) {
    _listeners[controller] = listener;
  }

  /// Remove the overlay state listener
  void removeListener(OverlayPortalController? controller) {
    if (controller != null) {
      _listeners.remove(controller);
    }
  }

  /// Notify listener about overlay state change
  void _notifyStateChange(bool isOpen) {
    if (_currentController != null && _listeners.containsKey(_currentController)) {
      for (var entry in _listeners.entries) {
        if (entry.key == _currentController) {
          entry.value(isOpen);
        }
      }
    }
  }

  void openOverlay(OverlayPortalController controller) {
    // Close the currently open overlay if any
    if (_currentController != null && _currentController != controller && _currentController!.isShowing) {
      _currentController!.hide();
    }

    _currentController = controller;
    _currentController!.show();
    _notifyStateChange(true);
  }

  void closeOverlay(OverlayPortalController controller) {
    if (_currentController == controller) {
      _currentController!.hide();
      _notifyStateChange(false);
      _currentController = null;
    }
  }
}
