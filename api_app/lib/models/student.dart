class Student {
  final int id;
  final String firstName;
  final String lastName;
  final String course; 
  final String year;
  final bool enrolled;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled
  });

  factory Student.fromSqlfliteDB(Map<String, dynamic> map) => Student(
    id: map["id"], 
    firstName: map["firstName"] ?? '', 
    lastName: map["lastName"] ?? '', 
    course: map["course"] ?? '', 
    year: map["year"] ?? '', 
    enrolled: map["bool"] == 0 ? false : true
  );

}