import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceTile extends StatelessWidget {
  const PlaceTile({required this.place, super.key});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSurface)),
    );
  }
}
