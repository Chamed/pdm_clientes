import 'package:flutter/material.dart';
import 'package:pdm_alfa/views/customer/customer_crud.view.dart';
import 'package:pdm_alfa/views/customer/customers.view.dart';
import 'package:pdm_alfa/views/home/components/card.component.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
