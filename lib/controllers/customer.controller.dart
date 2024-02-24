import 'package:pdm_alfa/models/customer.model.dart';

class CustomerController {
  Future<int> insertCustomer(
    String name,
    String phone,
    String email,
    DateTime dateOfBirth,
  ) {
    final Customer customerToInsert = Customer(
      name: name,
      phone: phone,
      email: email,
      dateOfBirth: dateOfBirth,
    );

    return CustomerModel.instance.insert(customerToInsert);
  }

  Future<List<Customer>> getAllCustomers() {
    return CustomerModel.instance.list();
  }
}
