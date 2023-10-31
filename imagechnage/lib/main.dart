import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that WidgetsBinding is initialized

  // Initialize the flutter_downloader plugin
  await FlutterDownloader.initialize(debug: true);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Wallpaper(),
  ));
}


class Wallpaper extends StatefulWidget {
  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];
  int currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
      headers: {
        'Authorization': 'juwboKsFB5u8sAuBkZo6RRYot200pD796KYiVt2XzxzAgS7AXEwINd4m ',
      },
    );

    if (response.statusCode == 200) {
      Map result = json.decode(response.body);
      setState(() {
        images = result['photos'];
        print("jhdhfjsdhfjdfhhj:$images");
      });
    }
  }

  void changeImage() {
    setState(() {
      currentImageIndex = (currentImageIndex + 1) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.orange,title: Center(child: Text("Change Image",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 340,
              height: 250,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.only(topLeft:Radius.circular(20),
         bottomRight: Radius.circular(20)),
       
        // shape:BoxShape.circle,
         color: Colors.orange,
       ),

              child: InkWell(
                onTap:()
                {
                 changeImage();
                },
                child: Image.network(

                  images.isEmpty
                      ? 'https://via.placeholder.com/300'
                      : images[currentImageIndex]['src']['tiny'],
                     width:250,
                     height:250,

                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.deepOrange.withOpacity(0.9); // Darker shade on press
                    }
                    return Colors.deepOrange.withOpacity(0.7); // Lighter shade on hover
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () {
                // Your button's action here
                changeImage();

              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.deepOrange, Colors.orangeAccent, Colors.white],
                  ),
                ),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(
                    'Change Image',
                    style: TextStyle(
                      color: Colors.white, // Change text color as needed
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
