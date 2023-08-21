import 'package:isar/isar.dart';

part 'cache_place.g.dart';

@collection
class CachePlace {
  CachePlace({
    required this.id,
    required this.title,
  }) : isarId = Isar.autoIncrement;

  late Id isarId;
  late String id;
  late String title;
}
