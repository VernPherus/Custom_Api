
import 'package:json_annotation/json_annotation.dart';
part 'student_model.g.dart';

@JsonSerializable()
class StudentModel {
  
  final String id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;
  final int versionKey;

  StudentModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
    required this.versionKey,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => _$StudentModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentModelToJson(this);

  // factory Student.fromJson(Map<String, dynamic> json) => Student(
  //     id: json["_id"],
  //     firstName: json["fname"],
  //     lastName: json["lname"],
  //     course: json["course"],
  //     year: json["year"],
  //     enrolled: json["enrolled"] == 0 ? false : true,
  //     versionKey: json["__v"]);
}
