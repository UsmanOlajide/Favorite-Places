import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var enteredTitle = '';
  void _addAPlace() {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
    // print(enteredTitle);
    Navigator.of(context).pop(enteredTitle);
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
                onPressed: () {
                  _addAPlace();
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Place'))
          ],
        ),
      ),
    );
  }
}
