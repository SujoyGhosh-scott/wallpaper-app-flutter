import 'package:flutter/material.dart';
import 'package:wallpapers/model/wallpaper_model.dart';
import 'package:wallpapers/views/image_view.dart';

Widget BrandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        "Wall",
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      Text(
        "Papers",
        style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 22),
      )
    ],
  );
}

Widget wallpapersList(List<WallpaperModel> wallpapers, context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ImageView(imgUrl: wallpaper.src.portrait)));
          },
          child: Hero(
            tag: wallpaper.src.portrait,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                wallpaper.src.portrait,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
      }).toList(),
    ),
  );
}
