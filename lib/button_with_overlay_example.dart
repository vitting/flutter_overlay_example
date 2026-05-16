import 'package:flutter/material.dart';
import 'package:flutter_overlay_example/button_with_overlay/button_with_overlay.dart';
import 'package:flutter_overlay_example/button_with_overlay/button_with_overlay_manager.dart';

class ButtonWithOverlayExample extends StatefulWidget {
  static const String routeName = '/button_with_overlay';
  const ButtonWithOverlayExample({super.key});

  @override
  State<ButtonWithOverlayExample> createState() => _ButtonWithOverlayExampleState();
}

class _ButtonWithOverlayExampleState extends State<ButtonWithOverlayExample> {
  final OverlayPortalController _controller1 = OverlayPortalController();
  final OverlayPortalController _controller2 = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button with Overlay Example')),
      backgroundColor: Colors.white,
      extendBody: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ButtonWithOverlay(
                  overlayController: _controller1,
                  label: 'Open Menu 1',
                  menuChild: Container(
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Material(
                          child: ListTile(
                            title: const Text('Option 1'),
                            onTap: () {
                              debugPrint('Option 1 selected');
                              ButtonWithOverlayManager().closeOverlay(_controller1);
                            },
                            hoverColor: Colors.grey.shade300,
                            tileColor: Colors.white,
                          ),
                        ),
                        Material(
                          child: ListTile(
                            title: const Text('Option 2'),
                            onTap: () {
                              debugPrint('Option 2 selected');
                              ButtonWithOverlayManager().closeOverlay(_controller1);
                            },
                            hoverColor: Colors.grey.shade300,
                            tileColor: Colors.white,
                          ),
                        ),
                        Material(
                          child: ListTile(
                            title: const Text('Option 3'),
                            onTap: () {
                              debugPrint('Option 3 selected');
                              ButtonWithOverlayManager().closeOverlay(_controller1);
                            },
                            hoverColor: Colors.grey.shade300,
                            tileColor: Colors.white,
                          ),
                        ),
                        Material(
                          child: ListTile(
                            title: const Text('Option 4'),
                            onTap: () {
                              debugPrint('Option 4 selected');
                              ButtonWithOverlayManager().closeOverlay(_controller1);
                            },
                            hoverColor: Colors.grey.shade300,
                            tileColor: Colors.white,
                          ),
                        ),
                        Material(
                          child: ListTile(
                            title: const Text('Option 5'),
                            onTap: () {
                              debugPrint('Option 5 selected');
                              ButtonWithOverlayManager().closeOverlay(_controller1);
                            },
                            hoverColor: Colors.grey.shade300,
                            tileColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ButtonWithOverlay(
                  overlayController: _controller2,
                  label: 'Open Menu 2',
                  menuChild: Container(
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Material(
                          child: ListTile(
                            title: const Text('Option 1'),
                            onTap: () {
                              debugPrint('Option 1 selected');
                              ButtonWithOverlayManager().closeOverlay(_controller2);
                            },
                            hoverColor: Colors.grey.shade300,
                            tileColor: Colors.white,
                          ),
                        ),
                        Material(
                          child: ListTile(
                            title: const Text('Option 2'),
                            onTap: () {
                              debugPrint('Option 2 selected');
                              ButtonWithOverlayManager().closeOverlay(_controller2);
                            },
                            hoverColor: Colors.grey.shade300,
                            tileColor: Colors.white,
                          ),
                        ),
                        Material(
                          child: ListTile(
                            title: const Text('Option 3'),
                            onTap: () {
                              debugPrint('Option 3 selected');
                              ButtonWithOverlayManager().closeOverlay(_controller2);
                            },
                            hoverColor: Colors.grey.shade300,
                            tileColor: Colors.white,
                          ),
                        ),
                        Material(
                          child: ListTile(
                            title: const Text('Option 4'),
                            onTap: () {
                              debugPrint('Option 4 selected');
                              ButtonWithOverlayManager().closeOverlay(_controller2);
                            },
                            hoverColor: Colors.grey.shade300,
                            tileColor: Colors.white,
                          ),
                        ),
                        Material(
                          child: ListTile(
                            title: const Text('Option 5'),
                            onTap: () {
                              debugPrint('Option 5 selected');
                              ButtonWithOverlayManager().closeOverlay(_controller2);
                            },
                            hoverColor: Colors.grey.shade300,
                            tileColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
