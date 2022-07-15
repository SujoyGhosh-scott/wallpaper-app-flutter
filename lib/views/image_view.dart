import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:wallpaper_manager/wallpaper_manager.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({required this.imgUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late final String imgView;

  // Future<void> setWallpaper() async {
  //   int location = WallpaperManager.HOME_SCREEN;
  //   // or location = WallpaperManager.LOCK_SCREEN;
  //   var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
  //   final String result =
  //       await WallpaperManager.setWallpaperFromFile(file.path, location);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Hero(
          tag: widget.imgUrl,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            GestureDetector(
              onTap: () async {
                //setWallpaper();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54, width: 1),
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                        colors: [Color(0x36ffffff), Color(0x0fffffff)])),
                child: Column(
                  children: const [
                    Text(
                      "Set Wallpaper",
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    Text(
                      "set image as homescreen wallpaper",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                _save();
                //Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54, width: 1),
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                        colors: [Color(0x36ffffff), Color(0x0fffffff)])),
                child: Column(
                  children: const [
                    Text(
                      "Save Wallpaper",
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    Text(
                      "Image will be saved in gallery",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 54,
            )
          ]),
        )
      ],
    ));
  }

  _save() async {
    await _askPermission();
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    //print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[
          Permission.storage]); // it should print PermissionStatus.granted
    }
  }
}
