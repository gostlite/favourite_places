import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceNotifier extends StateNotifier<List<Place>> {
  PlaceNotifier() : super([]);
  void addNewPlace(String title) {
    final newPlace = Place(title: title);
    state = [...state, newPlace];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Place>>((ref) {
  return PlaceNotifier();
});
