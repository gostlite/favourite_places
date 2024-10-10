import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlacesDetailsScreen extends StatelessWidget {
  const PlacesDetailsScreen({required this.place, super.key});
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${place.title} detail"),
      ),
      body: Center(child: Text(place.title)),
    );
  }
}
