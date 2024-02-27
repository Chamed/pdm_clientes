import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdm_alfa/models/customer.model.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerView extends StatelessWidget {
  final Customer customer;

  const CustomerView({
    Key? key,
    required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(customer.dateOfBirth);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do cliente'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Nome'),
            subtitle: Text(customer.name),
          ),
          ListTile(
            title: Text('Celular'),
            subtitle: Text(customer.phone),
            onTap: () {
              _launchPhoneDialer(customer.phone);
            },
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text(customer.email),
          ),
          ListTile(
            title: Text('Data de nascimento'),
            subtitle: Text(formattedDate),
          ),
        ],
      ),
    );
  }

  void _launchPhoneDialer(String phoneNumber) async {
    final Uri url = Uri.parse(
      'tel:$phoneNumber',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
