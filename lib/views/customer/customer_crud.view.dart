import 'package:flutter/material.dart';
import 'package:pdm_alfa/controllers/customer.controller.dart';

class CustomerCrudView extends StatefulWidget {
  const CustomerCrudView({Key? key}) : super(key: key);

  @override
  State<CustomerCrudView> createState() => _CustomerCrudViewState();
}

class _CustomerCrudViewState extends State<CustomerCrudView> {
  final CustomerController customerController = CustomerController();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  DateTime? dateOfBirth;

  Future<void> pickDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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
            ),
            const SizedBox(height: 25.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: emailController,
            ),
            const SizedBox(height: 35.0),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    dateOfBirth != null) {
                  customerController
                      .insertCustomer(
                        nameController.text,
                        phoneController.text,
                        emailController.text,
                        dateOfBirth!,
                      )
                      .then(
                        (value) => {Navigator.of(context).pop()},
                      );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Cliente não cadastrado'),
                        content: Text('Por favor, preencha todos os campos.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
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
