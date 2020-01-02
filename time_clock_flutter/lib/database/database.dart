import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_clock_flutter/database/dao/marcacao_dao.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'timeclock.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(MarcacaoDao.tableSql);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
