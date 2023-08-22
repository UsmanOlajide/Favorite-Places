// import 'dart:convert';

// import 'package:favorite_places/models/place.dart';
// import 'package:favorite_places/providers/places_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

// class RemoteNotifier extends StateNotifier<AsyncValue<List<Place>>> {
//   RemoteNotifier(this.ref) : super(const AsyncData([]));

//   final Ref ref;

//   void postAPlace() async {
//     state = const AsyncLoading();
//     final Uri url = Uri.http(
//         'places-app-de309-default-rtdb.firebaseio.com', 'places-app.json');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({'key': 'value'}),
//     );
//     final allPlaces = ref.read(placesProvider);
//     state = AsyncData(allPlaces);
//   }
// }

// final remoteProvider =
//     StateNotifierProvider<RemoteNotifier, AsyncValue<List<Place>>>((ref) {
//   return RemoteNotifier(ref);
// });

// //* This provider should control my http requests