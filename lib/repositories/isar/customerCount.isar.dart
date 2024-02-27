import 'package:isar/isar.dart';

part 'customerCount.isar.g.dart';

@collection
class CustomersCount {
  Id id = Isar.autoIncrement;

  int? count;
}
