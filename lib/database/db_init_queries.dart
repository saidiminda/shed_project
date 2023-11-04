import 'package:sqflite/sqflite.dart';

initQueries(Database db) async {
  await db.execute(''' 
      CREATE TABLE farm_models(
       id INT NOT NULL UNIQUE,
       name varchar(191) NOT NULL
        )
 ''');


}
