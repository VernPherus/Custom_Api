import 'package:sqflite/sqflite.dart';
import 'package:api_app/database/db_service.dart';
import 'package:api_app/models/student.dart';

class StudentsDB {
  final tableName = "students";

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "course" TEXT NOT NULL,
    "year" TEXT NOT NULL,
    "enrolled" INTEGER NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT)
    );
""");
  }
}
