import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cache_model/cache_place.dart';
import '../models/place.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();

  var enteredTitle = '';

  void _addAPlace() {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
    ref.read(isarServiceProvider.notifier).addPlace(
          CachePlace(
            id: DateTime.now().toIso8601String(),
            title: enteredTitle,
          ),
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ('Please enter a place to add');
                }
                return null;
              },
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              onSaved: (newValue) {
                setState(() {
                  enteredTitle = newValue!;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _addAPlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            )
          ],
        ),
      ),
    );
  }
}
// import 'package:favorite_places/providers/places_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/place.dart';

// class AddPlaceScreen extends ConsumerStatefulWidget {
//   const AddPlaceScreen({super.key});

//   @override
//   ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
// }

// class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
//   final _formKey = GlobalKey<FormState>();

//   var enteredTitle = '';

//   void _addAPlace() {
//     _formKey.currentState!.validate();
//     _formKey.currentState!.save();
//     ref.read(placesProvider.notifier).addPlace(
//           Place(
//             title: enteredTitle,
//             id: DateTime.now().toIso8601String(),
//           ),
//         );
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add new place'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return ('Please enter a place to add');
//                 }
//                 return null;
//               },
//               style: const TextStyle(color: Colors.white),
//               decoration: const InputDecoration(
//                 label: Text('Title'),
//               ),
//               onSaved: (newValue) {
//                 setState(() {
//                   enteredTitle = newValue!;
//                 });
//               },
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton.icon(
//               onPressed: _addAPlace,
//               icon: const Icon(Icons.add),
//               label: const Text('Add Place'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
