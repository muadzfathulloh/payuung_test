import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppSqlite {
  static final AppSqlite _instance = AppSqlite._internal();
  static Database? _database;
  static Database? _productDb;

  factory AppSqlite() {
    return _instance;
  }

  AppSqlite._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'profile.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<Database> get productDb async {
    if (_productDb != null) return _productDb!;
    _productDb = await _initProduct();
    return _productDb!;
  }

  Future<Database> _initProduct() async {
    String path = join(await getDatabasesPath(), 'product.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateProduct,
    );
  }

  Future<void> _onCreateProduct(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        image TEXT,
        original_price TEXT,
        price TEXT,
        discount TEXT
      )
    ''');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        tanggal_lahir TEXT,
        email TEXT,
        no_hp TEXT,
        jenis_kelamin TEXT,
        pendidikan TEXT,
        status_pernikahan TEXT,
        nik TEXT,
        alamat_ktp TEXT,
        kodepos TEXT,
        provinsi TEXT,
        kota TEXT,
        kecamatan TEXT,
        kelurahan TEXT,
        alamat_domisili TEXT,
        kodepos_domisili TEXT,
        provinsi_domisili TEXT,
        kota_domisili TEXT,
        kecamatan_domisili TEXT,
        kelurahan_domisili TEXT,
        nama_usaha TEXT,
        alamat_usaha TEXT,
        jabatan TEXT,
        lama_bekerja TEXT,
        sumber_pendapatan TEXT,
        pendapatan_kotor TEXT,
        nama_bank TEXT,
        nomor_rekening TEXT,
        cabang_bank TEXT,
        nama_pemilik_rekening TEXT
      )
    ''');
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    Database db = await database;
    return await db.insert('items', item);
  }

  Future<int> insertProduct(Map<String, dynamic> product) async {
    Database db = await productDb;
    return await db.insert('products', product);
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    Database db = await database;
    return await db.query('items');
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    Database db = await productDb;
    return await db.query('products');
  }

  Future<int> updateItem(int id, Map<String, dynamic> item) async {
    Database db = await database;
    return await db.update('items', item, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateProduct(int id, Map<String, dynamic> product) async {
    Database db = await productDb;
    return await db.update('products', product, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteItem(int id) async {
    Database db = await database;
    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteProduct(int id) async {
    Database db = await productDb;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    Database db = await database;
    await db.close();
  }

  Future<void> closeProduct() async {
    Database db = await productDb;
    await db.close();
  }
}
