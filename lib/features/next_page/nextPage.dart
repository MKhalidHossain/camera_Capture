import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final List<String> imagePaths;

  const NextPage({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Next Page")),
      body: Center(
        child: Text("You captured ${imagePaths.length} images."),
      ),
    );
  }
}