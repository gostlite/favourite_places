import "dart:io";

import "package:uuid/uuid.dart";

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;
  const PlaceLocation({
    required this.longitude,
    required this.latitude,
    required this.address,
  });
}

class Place {
  Place({required this.title, required this.image, required this.placeLocation})
      : id = uuid.v4();
  final String id;
  final String title;
  final File image;
  final PlaceLocation placeLocation;
}
