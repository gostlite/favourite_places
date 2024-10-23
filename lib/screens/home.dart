import 'package:favourite_places/widgets/places.dart';
import 'package:favourite_places/provider/place_provider.dart';
import 'package:favourite_places/screens/new_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late Future<void> _loadedPlaces;
  @override
  void initState() {
    _loadedPlaces = ref.read(placeProvider.notifier).loadDataBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewPlace()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _loadedPlaces,
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.done
                  ? Places(
                      places: places,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
    );
  }
}
