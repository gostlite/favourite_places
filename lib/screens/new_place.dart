import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/provider/place_provider.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final TextEditingController _place = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  @override
  void dispose() {
    _place.dispose();
    super.dispose();
  }

  void _getLocation(PlaceLocation pickedLocation) {
    _pickedLocation = pickedLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a place"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(label: Text("Title")),
                controller: _place,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInput(
                pickedImage: (image) {
                  _pickedImage = image!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              LocationInput(
                pickLocation: _getLocation,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_place.text.isEmpty ||
                      _pickedImage == null ||
                      _pickedLocation == null) {
                    return;
                  }
                  ref.read(placeProvider.notifier).addNewPlace(
                      _place.text, _pickedImage!, _pickedLocation!);
                  Navigator.pop(context);
                },
                label: const Text("Add place"),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
