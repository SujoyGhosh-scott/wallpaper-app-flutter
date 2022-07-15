import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:wallpapers/data/data.dart';
import 'package:wallpapers/model/wallpaper_model.dart';
import 'package:wallpapers/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;
  Search({required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();
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
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: BrandName(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.all(Radius.circular(24))),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        hintText: "Search wallpaper", border: InputBorder.none),
                  ),
                ),
                const Icon(Icons.search)
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          wallpapers.isEmpty
              ? const Text(
                  "No similar wallpapers found",
                  style: TextStyle(color: Colors.black38, fontSize: 18),
                )
              : wallpapersList(wallpapers, context),
          const SizedBox(
            height: 16,
          )
        ]),
      ),
    );
  }
}
