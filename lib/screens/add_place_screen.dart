import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var enteredTitle = '';
  var enteredNumber = 1;
  var enteredCategory = 'evil';

  void _addAPlace() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Uri url = Uri.https(
          'places-app-de309-default-rtdb.firebaseio.com', 'myplaces-app.json');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': enteredTitle,
        }),
      );
      print(response.body);
      final Map<String, dynamic> decodedData = json.decode(response.body);
      if (context.mounted) {
        Navigator.of(context).pop(
          Place(
            title: enteredTitle,
            id: decodedData['name'],
          ),
        );
      }
    }
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
