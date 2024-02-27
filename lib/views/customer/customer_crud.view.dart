import 'package:flutter/material.dart';
import 'package:pdm_alfa/controllers/customer.controller.dart';
import 'package:pdm_alfa/models/customer.model.dart';
import 'package:pdm_alfa/stores/counter.store.dart';
import 'package:provider/provider.dart';

class CustomerCrudView extends StatefulWidget {
  final Customer? customerToUpdate;
  final Function? callback;

  const CustomerCrudView({Key? key, this.customerToUpdate, this.callback})
      : super(key: key);

  @override
  State<CustomerCrudView> createState() => _CustomerCrudViewState();
}

class _CustomerCrudViewState extends State<CustomerCrudView> {
  // final CustomerController _customerController = CustomerController();

  CounterStore? _counterStore;
  CustomerController? _customerController;

  @override
  void didChangeDependencies() {
    _counterStore ??= Provider.of<CounterStore>(context);
    _customerController ??= CustomerController(counterStore: _counterStore!);
    super.didChangeDependencies();
  }

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  DateTime? dateOfBirth;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.customerToUpdate?.name ?? '');
    phoneController =
        TextEditingController(text: widget.customerToUpdate?.phone ?? '');
    emailController =
        TextEditingController(text: widget.customerToUpdate?.email ?? '');
    dateOfBirth = widget.customerToUpdate?.dateOfBirth;
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cliente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome'),
              controller: nameController,
            ),
            const SizedBox(height: 25.0),
            GestureDetector(
              onTap: () => pickDateOfBirth(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Data de nascimento'),
                  controller: TextEditingController(
                    text: dateOfBirth != null
                        ? '${dateOfBirth!.day}/${dateOfBirth!.month}/${dateOfBirth!.year}'
                        : '',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Celular'),
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 25.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 35.0),
            ElevatedButton(
              onPressed: () {
                final customer = Customer(
                  id: widget.customerToUpdate?.id ?? null,
                  name: nameController.text,
                  phone: phoneController.text,
                  email: emailController.text,
                  dateOfBirth: dateOfBirth!,
                );

                if (widget.customerToUpdate != null) {
                  _customerController!.updateCustomer(customer);
                } else {
                  _customerController!.insertCustomer(customer);
                }

                Navigator.of(context).pop();
                if (widget.callback != null) widget.callback!();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
