class WallpaperModel {
  late String photographer;
  late String photographer_url;
  late int photographer_id;
  late SrcModel src;

  WallpaperModel(
      {required this.photographer,
      required this.photographer_url,
      required this.photographer_id,
      required this.src});

  factory WallpaperModel.formMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        photographer: jsonData["photographer"],
        photographer_url: jsonData["photographer_url"],
        photographer_id: jsonData["photographer_id"],
        src: SrcModel.formMap(jsonData["src"]));
  }
}

class SrcModel {
  late String original;
  late String small;
  late String portrait;

  SrcModel(
      {required this.original, required this.small, required this.portrait});

  factory SrcModel.formMap(Map<String, dynamic> jsonData) {
    return SrcModel(
        original: jsonData["original"],
        small: jsonData["small"],
        portrait: jsonData["portrait"]);
  }
}
