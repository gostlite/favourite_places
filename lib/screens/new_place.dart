import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/provider/place_provider.dart';
import 'package:favourite_places/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final TextEditingController _place = TextEditingController();

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
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(label: Text("Title")),
            controller: _place,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (_place.text.isEmpty) {
                return;
              }
              ref.read(placeProvider.notifier).addNewPlace(_place.text);
              Navigator.pop(context);
            },
            label: const Text("Add place"),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
