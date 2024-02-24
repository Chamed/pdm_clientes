import 'package:flutter/material.dart';
import 'package:pdm_alfa/controllers/customer.controller.dart';
import 'package:pdm_alfa/models/customer.model.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({Key? key}) : super(key: key);

  @override
  State<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  final CustomerController customerController = CustomerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Clientes'),
      ),
      body: FutureBuilder<List<Customer>>(
        future: customerController.getAllCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final customer = snapshot.data![index];
                return ListTile(
                  title: Text(customer.name),
                  // You can add more information here if needed
                );
              },
            );
          } else {
            return const Center(
              child: Text('Sem clientes cadastrados.'),
            );
          }
        },
      ),
    );
  }
}
