import 'package:isar/isar.dart';
import 'package:pdm_alfa/repositories/isar/customerCount.isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarRepository {
  static final IsarRepository _instance = IsarRepository._internal();

  late Isar _isar;

  static IsarRepository get instance => _instance;

  IsarRepository._internal();

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [CustomersCountSchema],
      directory: dir.path,
    );
  }

  Future<void> incrementCustomerCounter() async {
    late CustomersCount newCount;
    final CustomersCount? customerCount =
        await _isar.customersCounts.where().findFirst();

    if (customerCount != null) {
      newCount = CustomersCount()
        ..id = customerCount.id
        ..count = customerCount.count! + 1;
    } else {
      newCount = CustomersCount()..count = 1;
    }

    await _isar.writeTxn(() async {
      await _isar.customersCounts.put(newCount);
    });
  }

  Future<int> getCurrentCustomerCounter() async {
    final CustomersCount? customerCount =
        await _isar.customersCounts.where().findFirst();

    return customerCount != null ? customerCount.count! : 0;
  }
}
