import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class RemoteNotifier extends StateNotifier<AsyncValue<List<Place>>> {
  RemoteNotifier() : super(const AsyncData([]));

  void postAPlace() async{
    state = const AsyncLoading();
    final Uri url = Uri.http('places-app-de309-default-rtdb.firebaseio.com','places-app.json');
    await http.post(
      url,
      headers: {
        'Content-Type' : 'application/json'
      },
      body: json.encode(
        {'key':'value'}
      ),
      
    );
  }
}

final remoteProvider =
    StateNotifierProvider<RemoteNotifier, AsyncValue<List<Place>>>((ref) {
  return RemoteNotifier();
});

//* This provider should control my http requests