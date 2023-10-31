import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class FlashLightView extends StatefulWidget {
  const FlashLightView({Key? key});

  @override
  State<FlashLightView> createState() => _FlashLightViewState();
}

class _FlashLightViewState extends State<FlashLightView> {
  bool isLightOn = false; // For light turn ON/OFF

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: const Text('Flashlight in Flutter')),
      ),
      body: Stack(
        children: [
          Image.asset(
            isLightOn ? 'assets/back1.jpeg' : 'assets/back.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150, // Set the desired width
                  height: 70,  // Set the desired height
                  child: Switch(
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.blueGrey,
                    value: isLightOn,
                    onChanged: (value) {
                      setState(() {
                        isLightOn = value;
                        if (isLightOn) {
                          TorchLight.enableTorch(); // Enable Flashlight
                        } else {
                          TorchLight.disableTorch(); // Disable Flashlight
                        }
                      });
                    },
                    splashRadius: 20,
                  ),
                ),
                Text(
                  isLightOn ? 'Flashlight ON' : 'Flashlight OFF',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
