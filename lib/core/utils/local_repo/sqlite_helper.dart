// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DBManger {
//   Database? _db;
//   String dbName = "my_store.db";
//   int dbVersion = 1;

//   /** start table and columns for products table */
//   static const String TBL_PRODUCTS = "favorates";
//   static const String COL_ID = "id";
//   static const String COL_TITLE = "title";
//   static const String COL_DESCRIPTION = "description";
//   static const String COL_PRICE = "price";
//   static const String COL_CATEGORY = "category";
//   static const String COL_IMAGE = "image";
//   // static const String COL_ISFAV = "is_favorate";

//   Future<Database> get dbObject async {
//     print("db is null");
//     if (_db == null) {
//       _db = await initDatabase();
//     }
//     ;
//     print("not nul");
//     return _db!;
//   }

//   Future<Database> initDatabase() async {
//     String dbFolder = await getDatabasesPath();
//     String dbPath = join(dbFolder, dbName);

//     return await openDatabase(dbPath, version: dbVersion, onCreate: (db, v) {
//       db.execute("""
//       create table if not exists $TBL_PRODUCTS (
//       $COL_ID integer primary key autoincrement,
//       $COL_TITLE varchar(255) not null,
//       $COL_DESCRIPTION text not null,
//       $COL_CATEGORY varchar(255) not null,
//       $COL_IMAGE varchar(255) not null,
//       $COL_PRICE double not null
     
//       )
//       """);
//     });
//   }

//   //add to table 
//   Future<int> insert(String tbl_name, Map<String, dynamic> row,
//     {String? mainTable_id = null, List<Map<String, dynamic>>? sub_rows = null}) async {
//   Database localDB = await dbObject;

//   // Check if the row already exists in the table
//   int? existingId = await checkIfRowExists(tbl_name, row);
//   if (existingId != null) {
//     // The row already exists, return the existing id
//     return existingId;
//   }

//   // Remove the 'id' key from the row map if it's present
//   if (row.containsKey(DBManger.COL_ID)) {
//     row.remove(DBManger.COL_ID);
//   }

//   int id = await localDB.insert(tbl_name, row);

//   sub_rows?.forEach((element) {
//     element[mainTable_id!] = id;
//   });

//   return id;
// }

// Future<int?> checkIfRowExists(String tbl_name, Map<String, dynamic> row) async {
//   Database localDB = await dbObject;

//   // Build the WHERE clause based on the row data
//   String whereClause = row.keys.map((key) => '$key = ?').join(' AND ');
//   List<Object?> whereArgs = row.values.toList();

//   // Query the table to check if the row already exists
//   List<Map<String, dynamic>> result = await localDB.query(tbl_name,
//       where: whereClause, whereArgs: whereArgs);

//   if (result.isNotEmpty) {
//     // The row already exists, return the id
//     return result.first[DBManger.COL_ID] as int;
//   } else {
//     // The row doesn't exist, return null
//     return null;
//   }
// }


//   /** delete from table */
//   Future<int> delete(String sql) async {
//     Database localDB = await dbObject;
//     return localDB.rawDelete(sql);
//   }

//   /** get from table */
//   Future<List<Map<String, dynamic>>> fetch(String sql) async {
//     Database localDB = await dbObject;
//     return localDB.rawQuery(sql);
//   }

//    Future<void> deleteAllData() async {
//     final db = await dbObject;
//     await db.delete(TBL_PRODUCTS);
//   }
// }