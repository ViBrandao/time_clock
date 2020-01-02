import 'package:sqflite/sqflite.dart';
import 'package:time_clock_flutter/models/marcacao.dart';

import '../database.dart';

class MarcacaoDao {
  static const String _tableName = 'marcacoes';
  static const String _id = 'id';
  static const String _data = 'data';
  static const String _hora = 'hora';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_data TEXT, '
      '$_hora TEXT)';

  Future<int> save(Marcacao marcacao) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(marcacao);
    return db.insert(_tableName, contactMap);
  }

  Future<List<Marcacao>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Marcacao> contacts = _toList(result);

    return contacts;
  }

  Future<List<Marcacao>> findAllByToday() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT * FROM $_tableName WHERE $_data LIKE "' +
            DateTime.now().day.toString() +
            '/' +
            DateTime.now().month.toString() +
            '/' +
            DateTime.now().year.toString() +
            '"');

    List<Marcacao> contacts = _toList(result);

    return contacts;
  }

  Map<String, dynamic> _toMap(Marcacao contact) {
    final Map<String, dynamic> contactMap = Map();

    contactMap[_data] = contact.data;
    contactMap[_hora] = contact.hora;
    return contactMap;
  }

  List<Marcacao> _toList(List<Map<String, dynamic>> result) {
    final List<Marcacao> contacts = List();

    for (Map<String, dynamic> row in result) {
      final Marcacao contact = Marcacao(
        row[_id],
        row[_data],
        row[_hora],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
