import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:healthcareapp/CartItemModel.dart';

class DbHelper {

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  onCreate(Database db, int version) async {
    db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName VARCHAR, price INTEGER, quantity INTEGER)'
    );
  }

  Future<CartItem> insert(CartItem cart) async {
    var dbClient = await db;

    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<CartItem>> getCartItems() async {
    var dbClient = await db;
    final List<Map<String, Object?>> cartItems = await dbClient!.query('cart');
    return cartItems.map((item) => CartItem.fromMap(item)).toList();
  }

  Future<int> updateQuantity(CartItem cartItem) async {
    var dbClient = await db;
    if (cartItem.quantity == 0) {
      return deleteCartItem(cartItem.id!);
    }
    return await dbClient!.update('cart', cartItem.toMap(),
      where: 'id = ?',
      whereArgs: [cartItem.id]
    );
  }

  Future<int> deleteCartItem(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('cart',
        where: 'id = ?',
        whereArgs: [id]
    );
  }
}