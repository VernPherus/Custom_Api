class Student {
  final int id;
  final String firstName;
  final String lastName;
  final String course; 
  final String year;
  final bool enrolled;
  final int versionkey;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
    required this.versionkey
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      id: json["_id"],
      firstName: json["fname"],
      lastName: json["lname"],
      course: json["course"],
      year: json["year"],
      enrolled: json["enrolled"],
      versionkey: json["__v"]);
}
