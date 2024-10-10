import 'package:favourite_places/components/place_tile.dart';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/places_details_screen.dart';
import 'package:flutter/material.dart';

class Places extends StatelessWidget {
  const Places({required this.places, super.key});
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return places.isEmpty
        ? Center(
            child: Text(
              "No items added yet",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          )
        : ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return PlacesDetailsScreen(
                          place: place,
                        );
                      }),
                    );
                  },
                  child: PlaceTile(place: place));
            });
  }
}
