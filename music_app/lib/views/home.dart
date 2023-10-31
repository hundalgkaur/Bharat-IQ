import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/consts/text_style.dart';
import 'package:music_app/controllers/player_controllers.dart';
import 'package:music_app/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return  Scaffold(
      backgroundColor: bgDarkColor,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){},
                icon: Icon(Icons.search,color:whiteColor))
          ],
          leading: Icon
            (Icons.sort_rounded,
            color: whiteColor,),
          title: Text("Music PLaylist",style:ourstyletitle()  ,),

        ),
        body:FutureBuilder<List<SongModel>>(future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL
        ), builder: (BuildContext context ,snapshot)
        {
          print("musicccccccccccccccc${snapshot.data}");
          if(snapshot.data == null )
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          else if(snapshot.data!.isEmpty)
            {
              return Center(child: Text("NO Songs Found",style: ourstylesubtitle(),));
            }
          else
        {
          return Padding(
          padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount:snapshot.data!.length,
        itemBuilder: (BuildContext context,int index)
        {
        return Container(
        margin: EdgeInsets.only(bottom: 4),

        child:  ListTile(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
          ),
          tileColor: bgColor,
          title: Text("${snapshot.data![index].displayNameWOExt}",style:ourstyletitle() ,),
          subtitle: Text("${snapshot.data![index].artist}",style: ourstylesubtitle(),),
          leading: QueryArtworkWidget(id:snapshot.data![index].id,type:ArtworkType.AUDIO ,
            nullArtworkWidget:
            Icon(Icons.music_note,color: whiteColor,size: 26,),),
          trailing: controller.playindex.value == index && controller.isPlay.value?Icon(Icons.play_arrow,color: whiteColor,size: 26,):null,
            onTap: ()
            {
              Get.to(Player(data:snapshot.data!),transition: Transition.downToUp);
              controller.playSong(snapshot.data![index].uri,index);
            },
          ),

        );
        }
        ),
        );
        }
            }

    ),);}

  }

