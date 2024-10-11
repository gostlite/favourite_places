import 'dart:io';

import 'package:favourite_places/components/image_input.dart';
import 'package:favourite_places/provider/place_provider.dart';
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

  @override
  void dispose() {
    _place.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a place"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(label: Text("Title")),
              controller: _place,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
            ElevatedButton.icon(
              onPressed: () {
                if (_place.text.isEmpty || _pickedImage == null) {
                  return;
                }
                ref
                    .read(placeProvider.notifier)
                    .addNewPlace(_place.text, _pickedImage!);
                Navigator.pop(context);
              },
              label: const Text("Add place"),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
