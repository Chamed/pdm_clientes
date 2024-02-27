import 'package:pdm_alfa/models/customer.model.dart';
import 'package:pdm_alfa/repositories/isar/isar.repository.dart';
import 'package:pdm_alfa/repositories/mongo.repository.dart';
import 'package:pdm_alfa/stores/counter.store.dart';

class CustomerController {
  final CounterStore counterStore;

  CustomerController({required this.counterStore});

  Future<int> insertCustomer(Customer customerToInsert) async {
    final int insertedId =
        await CustomerModel.instance.insert(customerToInsert);

    IsarRepository.instance.incrementCustomerCounter();
    counterStore.increment();
    return insertedId;
  }

  Future<void> updateCustomer(Customer customerToUpdate) {
    return CustomerModel.instance.update(customerToUpdate);
  }

  Future<void> deleteCustomer(int customerToDeleteId) {
    return CustomerModel.instance.softDelete(customerToDeleteId);
  }

  Future<List<Customer>> getAllCustomers() {
    return CustomerModel.instance.list();
  }

  // Future<int> getCustomersCount() {
  //   return IsarRepository.instance.getCurrentCustomerCounter();
  // }

  Future<void> initCounter() async {
    if (counterStore.loadingCounter) {
      int countFromIsar =
          await IsarRepository.instance.getCurrentCustomerCounter();
      counterStore.incrementBy(countFromIsar);

      counterStore.setLoading(false);
    }
  }

  Future<void> syncData() async {
    List<Customer> allCustomers = await getAllCustomers();

    await MongoRepository.instance.syncData(allCustomers, counterStore);
  }
}
