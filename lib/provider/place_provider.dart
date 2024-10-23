import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:path_provider/path_provider.dart" as syspath;
import "package:path/path.dart" as path;
import "package:sqflite/sqflite.dart" as sql;
import "package:sqflite/sqlite_api.dart";

Future<Database> _getDataBase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'user_places.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT )');
  }, version: 1);
  return db;
}

class PlaceNotifier extends StateNotifier<List<Place>> {
  PlaceNotifier() : super([]);
  Future<void> loadDataBase() async {
    final db = await _getDataBase();
    final data = await db.query("user_places");
    final places = data
        .map((row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            placeLocation: PlaceLocation(
                longitude: row['lng'] as double,
                latitude: row['lat'] as double,
                address: row['address'] as String)))
        .toList();
    state = places;
  }

  void addNewPlace(
      String title, File image, PlaceLocation placeLocation) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final imagePath = path.basename(image.path);
    final copiedImage = await image.copy("${appDir.path}/$imagePath");
    final newPlace =
        Place(title: title, image: copiedImage, placeLocation: placeLocation);
    final db = await _getDataBase();
    db.insert('user_places', {
      'title': title,
      'image': copiedImage,
      'lat': newPlace.placeLocation.latitude,
      'lng': newPlace.placeLocation.longitude,
      'address': newPlace.placeLocation.address,
    });

    state = [...state, newPlace];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Place>>((ref) {
  return PlaceNotifier();
});
