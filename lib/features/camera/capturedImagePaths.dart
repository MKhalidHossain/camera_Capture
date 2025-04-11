import 'dart:io';
import 'package:flutter/material.dart';

class CapturedImagesScreen extends StatelessWidget {
  final List<String> imagePaths;

  const CapturedImagesScreen({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Captured Images")),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: imagePaths.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return Image.file(File(imagePaths[index]), fit: BoxFit.cover);
        },
      ),
    );
  }
}
