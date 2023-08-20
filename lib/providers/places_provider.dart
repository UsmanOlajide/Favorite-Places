import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesProviderNotifier extends StateNotifier<List<FavoritePlace>> {
  PlacesProviderNotifier() : super([]);

  void addPlace(FavoritePlace place) {
    state = [...state, place];
  }
}

final placesProvider =
    StateNotifierProvider<PlacesProviderNotifier, List<FavoritePlace>>((ref) {
  return PlacesProviderNotifier();
});
