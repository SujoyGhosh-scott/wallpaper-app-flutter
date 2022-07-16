import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wallpapers/data/data.dart';
import 'package:http/http.dart' as http;
import 'package:wallpapers/widgets/widgets.dart';

import '../model/wallpaper_model.dart';

class CateGorie extends StatefulWidget {
  late final String categorieName;
  CateGorie(this.categorieName);

  @override
  State<CateGorie> createState() => _CateGorieState();
}

class _CateGorieState extends State<CateGorie> {
  List<WallpaperModel> wallpapers = [];

  getSearchWallpapers(String query) async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&page=1&per_page=20"),
        headers: {"Authorization": dotenv.env['API_KEY'].toString()});
    //print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element["id"]);
      WallpaperModel wallpaperModel;
      wallpaperModel = WallpaperModel.formMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpapers(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: BrandName(),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.abc),
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Text(
            "${widget.categorieName} wallpapers",
            style: const TextStyle(color: Colors.black54, fontSize: 20),
          ),
          const SizedBox(
            height: 16,
          ),
          wallpapersList(wallpapers, context),
          const SizedBox(
            height: 16,
          )
        ]),
      ),
    );
  }
}
