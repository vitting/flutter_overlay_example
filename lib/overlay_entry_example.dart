import 'dart:math';

import 'package:flutter/material.dart';

class OverlayEntryExample extends StatefulWidget {
  static const routeName = '/overlay-entry-example';
  const OverlayEntryExample({super.key});

  @override
  State<OverlayEntryExample> createState() => _OverlayEntryExampleState();
}

class _OverlayEntryExampleState extends State<OverlayEntryExample> {
  final List<OverlayEntry> _overlayEntries = [];
  OverlayEntry? _fullscreenOverlayEntry;
  int _random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  OverlayEntry _createOverlayEntry(double top, double left, String text, Color backgroundColor) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: top,
        left: left,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            height: 100,
            color: backgroundColor,
            child: Center(
              child: Text(text, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry _createFullscreenOverlayEntry(double top, double left, String text, Color backgroundColor) {
    final overlay = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Material(
          color: backgroundColor.withAlpha(180),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ElevatedButton(
                onPressed: () {
                  _fullscreenOverlayEntry!.remove();
                },
                child: const Text('Close Overlay'),
              ),
              Center(
                child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ],
          ),
        ),
      ),
    );

    return overlay;
  }

  OverlayEntry _createOverlayEntryWithAlign(String text, Color backgroundColor, AlignmentGeometry alignment) {
    return OverlayEntry(
      builder: (context) => Align(
        alignment: alignment,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            height: 100,
            color: backgroundColor,
            child: Center(
              child: Text(text, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OverlayEntry Example')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              final top = _random(100, 500).toDouble();
              final left = _random(100, 500).toDouble();
              final backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

              final overlay = _createOverlayEntry(top, left, 'This is an OverlayEntry ${DateTime.now()}', backgroundColor);
              _overlayEntries.add(overlay);
              Overlay.of(context).insert(overlay);
            },
            child: const Text('Show Overlay with Positioned'),
          ),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

              final overlay = _createOverlayEntryWithAlign('This is an OverlayEntry ${DateTime.now()}', backgroundColor, Alignment.topLeft);
              _overlayEntries.add(overlay);
              Overlay.of(context).insert(overlay);
            },
            child: const Text('Show Overlay with Align TopLeft'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

              final overlay = _createOverlayEntryWithAlign(
                'This is an OverlayEntry ${DateTime.now()}',
                backgroundColor,
                Alignment.bottomCenter,
              );
              _overlayEntries.add(overlay);
              Overlay.of(context).insert(overlay);
            },
            child: const Text('Show Overlay with Align BottomCenter'),
          ),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_overlayEntries.isNotEmpty) {
                _overlayEntries.last.remove();
                _overlayEntries.removeLast();
              }
            },
            child: const Text('Remove Last Overlay'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              for (var entry in _overlayEntries) {
                entry.remove();
              }
              _overlayEntries.clear();
            },
            child: const Text('Remove All Overlays'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final top = _random(100, 500).toDouble();
              final left = _random(50, 300).toDouble();
              final backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

              _fullscreenOverlayEntry = _createFullscreenOverlayEntry(
                top,
                left,
                'This is an OverlayEntry ${DateTime.now()}',
                backgroundColor,
              );

              Overlay.of(context).insert(_fullscreenOverlayEntry!);
            },
            child: const Text('Show Fullscreen Overlay'),
          ),
        ],
      ),
    );
  }
}
