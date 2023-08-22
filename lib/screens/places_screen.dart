import 'dart:convert';

import 'package:favorite_places/models/place.dart';

import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  List<Place> placesList = [];

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  void _loadPlaces() async {
    final Uri url = Uri.https(
        'places-app-de309-default-rtdb.firebaseio.com', 'myplaces-app.json');

    final response = await http.get(url);
    print(response.body);

    final Map<String, dynamic> decodedData = json.decode(response.body);

    List<Place> tempList = [];

    for (final entry in decodedData.entries) {
      tempList.add(
        Place(
          title: entry.value['title'],
          id: entry.key,
        ),
      );
    }
    setState(() {
      placesList = tempList;
    });
    //* I sent a POST request to store my data as json
    //* I send a GET request to retrieve my data which is in form of json
    //* I decode the json data which will be in form of Map<String,dynamic>
    //* I have to find a way to convert that Map into a list for me to use so I can update my UI
  }

  void _addPlace() async {
    final response = await Navigator.of(context).push<Place>(
      MaterialPageRoute(
        builder: (_) {
          return const AddPlaceScreen();
        },
      ),
    );

    if (response == null) {
      return;
    }
    setState(() {
      placesList.add(response);
    });
    // final Map<String, >decodedData = json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
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
              style: const TextStyle(color: Colors.white, fontSize: 25),
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
            onPressed: _addPlace,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
