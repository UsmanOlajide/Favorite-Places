import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:favorite_places/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  void _toAddPlace() {
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
    final placesList = ref.watch(isarServiceProvider);

    // Widget content = const Center(
    //   child: Text(
    //     'No places added yet!',
    //     style: TextStyle(color: Colors.white),
    //   ),
    // );

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
      body: placesList.when(
        loading: () => const SizedBox(
            height: 20, width: 20, child: CircularProgressIndicator()),
        data: (places) {
          if (places.isEmpty) {
            const Center(
              child: Text(
                'No places added yet!',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(
                  places[index].title,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            itemCount: places.length,
          );
        },
        error: (e, st) => Text(
          '$e',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
