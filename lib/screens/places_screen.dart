import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/place.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  void _toAddPlace()  {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const AddPlaceScreen();
        },
      ),
    );
    // print(addedPlace);
    // ref.read(placesProvider.notifier).addPlace(
    //       Place(
    //         title: addedPlace!,
    //         id: DateTime.now().toIso8601String(),
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    // print('RESTARTED');
    final placesList = ref.watch(placesProvider);

    Widget content = const Center(
      child: Text(
        'No places added yet!',
        style: TextStyle(color: Colors.white),
      ),
    );

    if (placesList.isNotEmpty) {
     content = ListView.builder(
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(
              placesList[index].title,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        itemCount: placesList.length,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: _toAddPlace,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
