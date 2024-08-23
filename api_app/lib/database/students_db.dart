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

  // Create
  Future<int> create(
      {required String firstName,
      required String lastName,
      required String course,
      required String year,
      required String enrolled}) async {
    final database = await DbService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName(firstName, lastName, course, year, enrolled) VALUES (?,?,?,?,?)''',
      [firstName, lastName, course, year, enrolled],
    );
  }

  //Read
  Future<List<Student>> fetchAll() async {
    final database = await DbService().database;
    final students = await database.rawQuery('''SELECT * FROM $tableName''');
    return students.map((student) => Student.fromSqlfliteDB(student)).toList();
  }

  Future<Student> fetchById(int id) async {
    final database = await DbService().database;
    final student = await database
        .rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [id]);
    return Student.fromSqlfliteDB(student.first);
  }

  //Update
  Future<int> update(
      {
      required int id,
      required String firstName,
      required String lastName,
      required String course,
      required String year,
      required String enrolled}) async {
    final database = await DbService().database;
    return await database.update(
      tableName,
      {
        'firstName' : firstName,
        'lastName': lastName,
        'course' : course,
        'year' : year,
        'enrolled' : enrolled
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  //Delete
  Future<void> delete(int id) async {
    final database = await DbService().database;
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }
}
