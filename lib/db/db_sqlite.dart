
import 'package:class_five/models/product_model.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';

class DBSqlite{
  static var productList= [];

  static final String CREATE_TABLE_PRODUCT = ''' create table $TABLE_PRODUCT(
  $COL_PRODUCT_ID integer primary key autoincrement,
  $COL_PRODUCT_NAME text not null, 
  $COL_PRODUCT_PRICE real not null,
  $COL_PRODUCT_CATEGORY text not null,
  $COL_PRODUCT_DATE text not null,
  $COL_PRODUCT_IMAGE text not null) ''';


  static Future<Database> open() async{
    final root= await getDatabasesPath();
    final dbPath = Path.join(root,'product_db');
    return openDatabase(dbPath,version: 1, onCreate: (db,version) async{
      await db.execute(CREATE_TABLE_PRODUCT);
    });
  }

  static Future<int> insertProduct(Product product) async {
    final db = await open();
    return db.insert(TABLE_PRODUCT, product.toMap());
  }


  static Future<List<Product>> getAllProducts() async {
    print('getAllProducts called');
    final db = await open();
    final List<Map<String, dynamic>> productMap = await db.rawQuery('select * from $TABLE_PRODUCT');
    return List.generate(productMap.length, (index) {
      return Product.fromMap(productMap[index]);
    });
  }

  static Future<int> deleteProduct (int id) async {
    final db = await open();
    return db.delete(TABLE_PRODUCT, where: '$COL_PRODUCT_ID = ?', whereArgs: [id]);
  }

}