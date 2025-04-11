import 'dart:io';
import 'package:camera/camera.dart';
import 'package:camera_practice/features/camera/capturedImagePaths.dart';
import 'package:camera_practice/features/next_page/nextPage.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// ✅ create this page (replace with your real next page)

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  List<String> capturedImagePaths = [];
  final int maxImages = 3;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      controller = CameraController(cameras[0], ResolutionPreset.high);
      await controller!.initialize();
      setState(() {});
    }
  }

  Future<void> captureAndSaveImage() async {
    if (capturedImagePaths.length >= maxImages) {
      // Already hit limit
      return;
    }

    try {
      final XFile image = await controller!.takePicture();
      final dir = await getApplicationDocumentsDirectory();
      final filePath = join(
        dir.path,
        '${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await image.saveTo(filePath);

      setState(() {
        capturedImagePaths.add(filePath);
      });

//       if (mounted) {
//   Future.delayed(Duration.zero, () {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Image saved')),
//     );
//   });
// }
    } catch (e) {
      print("Capture error: $e");
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: controller!.value.aspectRatio,
            child: CameraPreview(controller!),
          ),
          const SizedBox(height: 10),

          /// Only show capture button if under limit
          if (capturedImagePaths.length < maxImages)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF90B34B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: captureAndSaveImage,
              icon: const Text("Capture", style: TextStyle(fontSize: 16)),
              label: const Icon(Icons.camera_alt_rounded, color: Colors.white),
            ),

          /// Once 3 images captured → show "Continue"
          if (capturedImagePaths.length == maxImages)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => NextPage(imagePaths: capturedImagePaths),
                  ),
                );
              },
              icon: const Text("Continue", style: TextStyle(fontSize: 16)),
              label: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              if (capturedImagePaths.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CapturedImagesScreen(
                          imagePaths: capturedImagePaths,
                        ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No images captured yet!")),
                );
              }
            },
            child: const Text("View Captured Images"),
          ),
        ],
      ),
    );
  }
}
