import 'package:bdelete/api/apiResponse.dart';
import 'package:bdelete/model/loginModel.dart';
import 'package:bdelete/model/signupModel.dart';
import 'package:bdelete/model/testModel.dart';

abstract class ApiService {
  Future<ApiResponse> saveStudent(SignupModel signupModel);
  Future<ApiResponse> getData();
  Future<ApiResponse> deleteData(String id);
  Future<ApiResponse> updateStudent(SignupModel signupModel);
  //login
  Future<ApiResponse> saveLogin(LoginModel loginModel);
  Future<ApiResponse> getLoginData();
  Future<ApiResponse> deleteLoginData(String id);
  Future<ApiResponse> updateLogin(LoginModel loginModel);
  //checklogin
  Future<ApiResponse> checkLogin(LoginModel loginModel);
  //task
  Future<ApiResponse> task(TestModel testModel);
  //yesma login vanya chaii signup xa ani checklogin vanya chaii login ho
  Future<ApiResponse> checkUserDataOnLogin(LoginModel loginModel);
}
