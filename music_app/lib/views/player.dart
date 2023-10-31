import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:music_app/consts/colors.dart';
import 'package:music_app/consts/text_style.dart';
import 'package:music_app/controllers/player_controllers.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatefulWidget {
  final List<SongModel> data;


  const Player({Key? key, required this.data}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  var controller = Get.find<PlayerController>();
  bool isPlaying = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8,8,8,0),
        child: Column(
          children: [
            Obx(()
        =>
               Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 300,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: QueryArtworkWidget(
                    id: widget.data[controller.playindex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: Icon(Icons.music_note, color: whiteColor, size: 40),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Obx(() =>
                   Column(
                    children: [
                      Text(widget.data[controller.playindex.value].displayNameWOExt,
                          textAlign:TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: ourstyletitle1()),
                      SizedBox(height: 12),
                      Text(widget.data[controller.playindex.value].artist.toString(),
                          textAlign:TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: ourstylesubtitle1()),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Text(controller.position.value, style: ourslide()),
                          Expanded(
                            child: Slider(
                              thumbColor: slideColor,
                              inactiveColor: bgColor,
                              activeColor: slideColor,
                              min: Duration(seconds: 0).inSeconds.toDouble(),
                              max:controller.max.value,
                              value: controller.value.value,
                              onChanged: (newValue) {
                                controller.changeDurationToSeconds(newValue.toInt());
                                newValue=newValue;
                                setState(() {
                                  // Update the slider value here
                                });
                              },
                            ),
                          ),
                          Text(controller.duration.value, style: ourslide()),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {

                              controller.playSong( widget.data[controller.playindex.value-1].uri,controller.playindex.value-1);
                            },
                            icon: Icon(Icons.skip_previous_rounded, size: 40),
                          ),
                          CircleAvatar(
                            backgroundColor: bgDarkColor,
                            radius: 35,
                            child: Transform.scale(
                              scale: 2.5,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (isPlaying) {
                                      controller.audioPlayer.pause();
                                      isPlaying = false;
                                    } else {
                                      controller.audioPlayer.play();
                                      isPlaying = true;
                                    }
                                  });
                                },
                                icon: isPlaying
                                    ? const Icon(Icons.pause, color: whiteColor)
                                    : const Icon(Icons.play_arrow_rounded, color: whiteColor),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.playSong(widget.data[controller.playindex.value+1].uri,controller.playindex.value+1);
                            },
                            icon: Icon(Icons.skip_next_rounded, size: 40),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
