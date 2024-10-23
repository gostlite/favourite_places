import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/map.dart';
import 'package:flutter/material.dart';

class PlacesDetailsScreen extends StatelessWidget {
  const PlacesDetailsScreen({required this.place, super.key});
  final Place place;

  String get locationImage {
    final lat = place.placeLocation.latitude;
    final lng = place.placeLocation.longitude;

    return "https://maps.geoapify.com/v1/staticmap?style=osm-bright&width=600&height=400&center=lonlat:$lng,$lat&zoom=11.5617&scaleFactor=2&apiKey=62fa5664709346f1a1ddfed3094a4463";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${place.title} detail"),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              bottom: 2,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MapScreen(
                            place: PlaceLocation(
                                longitude: place.placeLocation.longitude,
                                latitude: place.placeLocation.latitude,
                                address: place.placeLocation.address),
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(locationImage),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black54]),
                    ),
                    child: Text(
                      place.placeLocation.address,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
