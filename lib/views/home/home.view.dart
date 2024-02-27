import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pdm_alfa/controllers/customer.controller.dart';
import 'package:pdm_alfa/stores/counter.store.dart';
import 'package:pdm_alfa/views/customer/customer_crud.view.dart';
import 'package:pdm_alfa/views/customer/customers.view.dart';
import 'package:pdm_alfa/views/home/components/card.component.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CounterStore? _counterStore;
  CustomerController? _customerController;

  @override
  void didChangeDependencies() {
    _counterStore ??= Provider.of<CounterStore>(context);
    _customerController ??= CustomerController(counterStore: _counterStore!);
    _customerController!.initCounter();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clientes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(
          top: 30.0,
          bottom: 40.0,
          left: 25.0,
          right: 25.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[200],
              ),
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Clientes cadastrados',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Observer(builder: (_) {
                    if (_counterStore!.loadingCounter) {
                      return CircularProgressIndicator();
                    } else {
                      return Text(
                        _counterStore!.value.toString(),
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  })
                  // FutureBuilder<int>(
                  //   future: customerController.getCustomersCount(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return CircularProgressIndicator();
                  //     } else if (snapshot.hasError) {
                  //       return Text('Error: ${snapshot.error}');
                  //     } else {
                  //       return Text(
                  //         snapshot.data.toString(),
                  //         style: TextStyle(
                  //           color: Colors.green,
                  //           fontSize: 36.0,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
            Spacer(),
            CardComponent(
              iconData: Icons.people_alt,
              label: 'Todos clientes',
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CustomersView(),
                  ),
                )
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            CardComponent(
              iconData: Icons.add_reaction_sharp,
              label: 'Adicionar novo cliente',
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CustomerCrudView(),
                  ),
                )
              },
            )
          ],
        ),
      ),
    );
  }
}
