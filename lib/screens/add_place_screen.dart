import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var enteredTitle = '';

  // void _addAPlace() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     Navigator.of(context).pop(enteredTitle);
  //   }
  // }

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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ref.read(placesProvider.notifier).addPlace(
                          Place(
                            title: enteredTitle,
                            id: DateTime.now().toIso8601String(),
                          ),
                        );
                    Navigator.of(context).pop(enteredTitle);
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Place'))
          ],
        ),
      ),
    );
  }
}
