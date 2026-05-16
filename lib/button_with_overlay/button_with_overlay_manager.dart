import 'package:flutter/material.dart';

class ButtonWithOverlayManager {
  static final ButtonWithOverlayManager _instance = ButtonWithOverlayManager._internal();

  factory ButtonWithOverlayManager() {
    return _instance;
  }

  ButtonWithOverlayManager._internal();

  OverlayPortalController? _currentController;

  /// Listener callback for overlay state changes (true = open, false = closed)
  Function(bool isCurrentButtonOpen)? _onOverlayStateChanged;

  /// Add a listener for overlay open/close state changes
  void addListener(Function(bool isCurrentButtonOpen) listener) {
    _onOverlayStateChanged = listener;
  }

  /// Remove the overlay state listener
  void removeListener() {
    _onOverlayStateChanged = null;
  }

  /// Notify listener about overlay state change
  void _notifyStateChange(bool isOpen) {
    _onOverlayStateChanged?.call(isOpen);
  }

  void openOverlay(OverlayPortalController controller) {
    // Close the currently open overlay if any
    if (_currentController != null && _currentController != controller && _currentController!.isShowing) {
      _currentController!.hide();
    }
    _currentController = controller;
    _notifyStateChange(true);
  }

  void closeOverlay(OverlayPortalController controller) {
    if (_currentController == controller) {
      _currentController!.hide();
      _currentController = null;
      _notifyStateChange(false);
    }
  }
}
