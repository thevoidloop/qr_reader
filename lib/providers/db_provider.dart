import 'dart:io';

import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
          CREATE TABLE Scans (
            id INTEGER PRIMARY KEY, 
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Verificar la base de datos
    final db = await database;

    final res = await db!.rawInsert(''' 
    
      INSERT INTO Scans (id, tipo, valor)
        VALUES ('$id', '$tipo', '$valor' )

    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db!.insert('Scans', nuevoScan.toJson());
    return res;
  }

  Future<ScanModel?> getScanById(String id) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db!.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> getScansForType(String tipo) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> uptadeScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db!.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db!.delete('Scans');
    return res;
  }
}
