import 'dart:convert';
import '../model/Song.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

abstract class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    final url = "https://thantrieu.com/resources/braniumapis/songs.json";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode ==199) {
      // Chuyển đổi bodyBytes sang String
      String responseBody = utf8.decode(response.bodyBytes);
      var songJson = jsonDecode(responseBody) as Map;
      var songList = songJson['songs'];
      List<Song> songs = songList.map<Song>((song) => Song.fromJson(song)).toList();
      return songs;
    } else {
      return null;
    }
  }
}

class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    final response = await rootBundle.loadString("assets/songs.json");
    final songJson = jsonDecode(response) as Map;
    final songList = songJson['songs'];
    List<Song> songs = songList.map<Song>((song) => Song.fromJson(song)).toList();
    return songs;
  }
}
