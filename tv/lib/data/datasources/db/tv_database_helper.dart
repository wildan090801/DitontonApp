import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:tv/data/models/tv_table.dart';

class DatabaseHelperTvs {
  static DatabaseHelperTvs? _databaseHelperTv;
  DatabaseHelperTvs._instance() {
    _databaseHelperTv = this;
  }

  factory DatabaseHelperTvs() =>
      _databaseHelperTv ?? DatabaseHelperTvs._instance();

  static Database? _databaseTvs;

  Future<Database?> get databaseTvs async {
    _databaseTvs ??= await _initDb();
    return _databaseTvs;
  }

  static const String _tblWatchlistTv = 'watchlisttv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditontontv.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistTv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertTvWatchlist(TvTable tv) async {
    final db = await databaseTvs;
    return await db!.insert(_tblWatchlistTv, tv.toJson());
  }

  Future<int> removeTvWatchlist(TvTable tv) async {
    final db = await databaseTvs;
    return await db!.delete(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await databaseTvs;
    final results = await db!.query(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await databaseTvs;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistTv);

    return results;
  }
}
