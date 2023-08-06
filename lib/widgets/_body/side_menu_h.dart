import 'package:flutter/material.dart';

class SideH extends StatelessWidget {
  const SideH({super.key});

  @override
  Widget build(context) {
    return Scaffold(
        body: SizedBox.expand(
          child: Row(
            children: [
              SizedBox.expand(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: const Center(child: Text("BODY")),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: const Center(child: Text(" < ")),
                ),
              ),
            ],
          ),
        ),
        endDrawer: Drawer());
  }
}
