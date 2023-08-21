
import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/cache_model/cache_place.dart';

class IsarService extends StateNotifier<AsyncValue<List<Place>>> {
  IsarService(this.ref) : super(const AsyncData([])) {
    getPlaces();
  }

  final Ref ref;

  Future<void> addPlace(CachePlace place) async {
    try {
      state = const AsyncLoading();
      final isar = await ref.read(_isarProvider.future);
      await isar.writeTxn(() async => await isar.cachePlaces.put(place));
      final allPlaces = await isar.cachePlaces.where().findAll();
      state = AsyncData(_convertCachePlaceToPlace(allPlaces));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> getPlaces() async {
    try {
      state = const AsyncLoading();
      final isar = await ref.read(_isarProvider.future);
      final allPlaces = await isar.cachePlaces.where().findAll();
      state = AsyncData(_convertCachePlaceToPlace(allPlaces));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

List<Place> _convertCachePlaceToPlace(List<CachePlace> cachePlace) {
  return cachePlace.map(Place.fromCachePlace).toList();
}

final isarServiceProvider =
    StateNotifierProvider<IsarService, AsyncValue<List<Place>>>((ref) {
  return IsarService(ref);
});

final _isarProvider = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open([CachePlaceSchema], directory: dir.path);
});
