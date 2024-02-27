import 'package:flutter/material.dart';
import 'package:pdm_alfa/controllers/customer.controller.dart';
import 'package:pdm_alfa/models/customer.model.dart';
import 'package:pdm_alfa/stores/counter.store.dart';
import 'package:pdm_alfa/views/customer/customer.view.dart';
import 'package:pdm_alfa/views/customer/customer_crud.view.dart';
import 'package:provider/provider.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({Key? key}) : super(key: key);

  @override
  State<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  //final CustomerController customerController = CustomerController();

  CounterStore? _counterStore;
  CustomerController? _customerController;

  @override
  void didChangeDependencies() {
    _counterStore ??= Provider.of<CounterStore>(context);
    _customerController ??= CustomerController(counterStore: _counterStore!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Clientes'),
        actions: [
          IconButton(
            onPressed: () => {
              _customerController!
                  .getAllCustomers()
                  .then((_) => setState(() => {}))
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () => {
              _customerController!.syncData().then((_) => _customerController!
                  .getAllCustomers()
                  .then((_) => setState(() => {})))
            },
            icon: Icon(Icons.sync),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _customerController!.getAllCustomers();

          setState(() {});
        },
        child: FutureBuilder<List<Customer>>(
          future: _customerController!.getAllCustomers(),
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
              return Padding(
                padding: const EdgeInsets.only(bottom: 75.0),
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (context, index) {
                    final customer = snapshot.data![index];

                    return ListTile(
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CustomerView(
                              customer: customer,
                            ),
                          ),
                        )
                      },
                      title: Text(customer.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CustomerCrudView(
                                    customerToUpdate: customer,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Excluir cliente'),
                                  content: Text(
                                    'Tem certeza que deseja excluir ${customer.name}?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _customerController!
                                            .deleteCustomer(customer.id!);

                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: Text('Excluir'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text('Sem clientes cadastrados.'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CustomerCrudView(
                callback: () {
                  _customerController!.getAllCustomers().then(
                        (_) => setState(() => {}),
                      );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
