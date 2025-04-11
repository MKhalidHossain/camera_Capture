import 'package:camera_practice/features/camera/camera.dart';
import 'package:flutter/material.dart';


class BehelarScreen extends StatefulWidget {
  const BehelarScreen({super.key});

  @override
  State<BehelarScreen> createState() => _BehelarScreenState();
}

class _BehelarScreenState extends State<BehelarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          // Header with green background and logo
          Container(
            color: Color(0xFF90B34B), // approximate green from screenshot
            padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
            child: Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.white, size: 28),
                Spacer(),
                Text(
                  'BÄHLER',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(width: 4),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 12,
                  child: Text("B", style: TextStyle(color: Colors.black)),
                ),
                Spacer(),
                Icon(Icons.menu, color: Colors.white),
              ],
            ),
          ),

          // Image and text section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Image.asset(
                      'images/backgroud.jpg',
                      fit: BoxFit.cover,
                      height: 220,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Now we need you to take 3 photos of each foot. Our AI then creates a perfect 3D model of your feet (including the shape of your soles), which defines the profile of your insoles.",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Button: Watch how it's done
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 20,
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.play_arrow, color: Colors.white),
                      label: Text(
                        "Please watch how it's done",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Button: Next
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF90B34B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        // Navigate to the next screen or perform an action
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraScreen(),
                          ),
                        );
                      },
                      icon: Text("Next", style: TextStyle(fontSize: 16)),
                      label: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
