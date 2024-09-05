import 'package:api_app/models/student_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api-students.vercel.app')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/students')
  Future<List<StudentModel>> fetchStudents();

  @GET('/student/:id')
  Future<StudentModel> fetchStudentById();

  @POST('/student/create')
  Future<StudentModel> createStudent();

  @PUT('/student/:id')
  Future<StudentModel> updateStudent();

  @DELETE('/student/delete/:id')
  Future<StudentModel> deleteStudent();
}