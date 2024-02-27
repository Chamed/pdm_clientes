import 'package:dio/dio.dart';
import 'package:pdm_alfa/controllers/customer.controller.dart';
import 'package:pdm_alfa/models/customer.model.dart';
import 'package:pdm_alfa/stores/counter.store.dart';

class MongoRepository {
  static final MongoRepository _instance = MongoRepository._internal();

  static MongoRepository get instance => _instance;

  MongoRepository._internal();

  Future<void> syncData(
    List<Customer> allCustomers,
    CounterStore counterStore,
  ) async {
    final dio = Dio();

    List<Map<String, dynamic>> jsonData =
        allCustomers.map((customer) => customer.toJson()).toList();

    Response response = await dio.post(
      'http://10.1.1.203:3333/customers',
      data: jsonData,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;

      print(response.data);
      if (responseData.containsKey('customersToAdd')) {
        List<Customer> customersToAdd = (responseData['customersToAdd'] as List)
            .map((json) => Customer.fromJson(json))
            .toList();

        for (Customer customer in customersToAdd) {
          await CustomerController(counterStore: counterStore)
              .insertCustomer(customer);
        }

        print('Customers added to SQLite successfully!');
      }
    } else {
      print('error: ${response.statusCode}');
    }
  }
}
