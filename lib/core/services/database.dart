// import 'package:ecommerce/constant.dart';
// import 'package:ecommerce/model/cart_product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../constant.dart';
import '../../model/product_model.dart';

class ProductDatabaseHelper {
  static Database? _database;

  static final ProductDatabaseHelper db = ProductDatabaseHelper._();
  ProductDatabaseHelper._();

  Future<Database> get database async => _database ??= await initDb();
  //       Future<Database> get database async {
  //   if (_database?? ) {
  //     _database = await _initiateDatabase();
  //   }
  //   return _database;
  // }

  initDb() async {
    //define the path to the database
    //بنحدد مكان الداتا بيز من علي الموباايل بتاعنا
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      //create tables
      await db.execute('''
      CREATE TABLE $tableProduct (
        $columnName TEXT NOT NULL,
        $columnPrice TEXT NOT NULL,
        $columnQuantity TEXT NOT NULL,
        $columnbarcodeNumber TEXT NOT NULL,
        $columnImage TEXT NOT NULL)
       ''');
    }, onUpgrade: (Database db, int oldV, int newV) async {
      if (oldV < newV) {
        await db.execute("alter table courses add column level varchar(50) ");
      }
    });
  }

  Future<List<ProductModel>> getAllProduct() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(tableProduct!);
    List<ProductModel> list = maps.isNotEmpty
        ? maps.map((product) => ProductModel.fromJson(product)).toList()
        : [];
    return list;
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<ProductModel>> queryProduct(String model) async {
    var dbClient = await database;
    // final List<Map<String, dynamic>> maps = await dbClient.query(tableProduct!);

    List<Map> map = await dbClient
        .rawQuery('SELECT * FROM product WHERE barcodeNumber=?', [model]);
    List<ProductModel> list = map.isNotEmpty
        ? map.map((product) => ProductModel.fromJson(product)).toList()
        : [];

    return list;
  }

  insert(ProductModel model) async {
    var dbClient = await database;
    await dbClient.insert(tableProduct!, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateProduct(ProductModel model) async {
    var dbClient = await database;
    return await dbClient.update(tableProduct!, model.toJson(),
        where: '$columnbarcodeNumber = ?', whereArgs: [model.barcodeNumber]);
  }

  // return maps
  //     .map((e) => Model(
  //         id: e["id"], fruitName: e["fruitName"], quantity: e["quantity"]))
  //     .toList();
}




//   Future<Database> createDatabase() async {
//     if (_db != null) {
//       return _db;
//     }
//     //define the path to the database
//     //بنحدد مكان الداتا بيز من علي الموباايل بتاعنا
//     String path = join(await getDatabasesPath(), 'school.db');
//     _db = await openDatabase(path, version: 2, onCreate: (Database db, int v) {
//       //create tables
//       db.execute(
//           'create table courses(id integer primary key autoincrement, name varchar(50), content varchar(255), hours integer)');
//     }, onUpgrade: (Database db, int oldV, int newV) async {
//       if (oldV < newV) {
//         await db.execute("alter table courses add column level varchar(50) ");
//       }
//     });
//     return _db;
//   }

//   Future<int> createCourse(Course course) async {
//     Database db = await createDatabase();
//     //db.rawInsert('insert into courses value')
//     return db.insert('courses', course.toMap());
//   }

//   Future<List> allCourses() async {
//     Database db = await createDatabase();
//     //db.rawQuery('select * from courses');
//     return db.query('courses');
//   }

//   Future<int> delete(int id) async {
//     Database db = await createDatabase();
//     return db.delete('courses', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<int> courseUpdate(Course course) async {
//     Database db = await createDatabase();
//     return await db.update('courses', course.toMap(),
//         where: 'id = ?', whereArgs: [course.id]);
//   }
// }
