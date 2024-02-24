//CLASSES

import 'package:pdm_alfa/repositories/keys/sqflite.keys.dart';
import 'package:pdm_alfa/repositories/sqflite.repository.dart';
import 'package:sqflite/sqflite.dart';

class Customer {
  final int? id;
  final String name;
  final String phone;
  final String email;
  final DateTime dateOfBirth;

  Customer({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.dateOfBirth,
  });
}

class CustomerModel {
  CustomerModel._();

  static final CustomerModel _instance = CustomerModel._();

  static CustomerModel get instance => _instance;

  Future<int> insert(Customer customerToInsert) async {
    Database sqfliteDB = await SqfliteRepository.instance.database;

    int id = await sqfliteDB.insert(
      SqfliteKeys.customerTable,
      {
        SqfliteKeys.customerName: customerToInsert.name,
        SqfliteKeys.customerPhone: customerToInsert.phone,
        SqfliteKeys.customerEmail: customerToInsert.email,
        SqfliteKeys.customerDateOfBirth:
            customerToInsert.dateOfBirth.toIso8601String(),
      },
    );

    return id;
  }

  Future<List<Customer>> list() async {
    Database sqfliteDB = await SqfliteRepository.instance.database;

    List<Map<String, dynamic>> maps =
        await sqfliteDB.query(SqfliteKeys.customerTable);

    return List.generate(maps.length, (i) {
      return Customer(
        id: maps[i][SqfliteKeys.id],
        name: maps[i][SqfliteKeys.customerName],
        phone: maps[i][SqfliteKeys.customerPhone],
        email: maps[i][SqfliteKeys.customerEmail],
        dateOfBirth: DateTime.parse(maps[i][SqfliteKeys.customerDateOfBirth]),
      );
    });
  }

  Future<Customer> getById(int id) async {
    Database sqfliteDB = await SqfliteRepository.instance.database;

    List<Map<String, dynamic>> maps = await sqfliteDB.query(
      SqfliteKeys.customerTable,
      where: "${SqfliteKeys.id} = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Customer(
        id: maps[0][SqfliteKeys.id],
        name: maps[0][SqfliteKeys.customerName],
        phone: maps[0][SqfliteKeys.customerPhone],
        email: maps[0][SqfliteKeys.customerEmail],
        dateOfBirth: DateTime.parse(maps[0][SqfliteKeys.customerDateOfBirth]),
      );
    } else {
      throw Exception('Customer not found');
    }
  }

  Future<void> update(Customer updatedCustomer) async {
    Database sqfliteDB = await SqfliteRepository.instance.database;

    await sqfliteDB.update(
      SqfliteKeys.customerTable,
      {
        SqfliteKeys.customerName: updatedCustomer.name,
        SqfliteKeys.customerPhone: updatedCustomer.phone,
        SqfliteKeys.customerEmail: updatedCustomer.email,
        SqfliteKeys.customerDateOfBirth:
            updatedCustomer.dateOfBirth.toIso8601String(),
      },
      where: "${SqfliteKeys.id} = ?",
      whereArgs: [updatedCustomer.id],
    );
  }

  Future<void> softDelete(int id) async {
    Database sqfliteDB = await SqfliteRepository.instance.database;

    await sqfliteDB.update(
      SqfliteKeys.customerTable,
      {SqfliteKeys.customerDeleted: true},
      where: "${SqfliteKeys.id} = ?",
      whereArgs: [id],
    );
  }
}
