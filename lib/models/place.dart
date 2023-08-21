import 'cache_model/cache_place.dart';

class Place {
  Place({required this.title, required this.id});

  final String title;
  final String id;

  factory Place.fromCachePlace(CachePlace place) {
    return Place(title: place.title, id: place.id);
  }
}
