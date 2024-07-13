import 'package:bdelete/api/api.dart';
import 'package:bdelete/api/apiConst.dart';
import 'package:bdelete/api/apiResponse.dart';
import 'package:bdelete/api/apiService.dart';
import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/core/helper.dart';
import 'package:bdelete/model/loginModel.dart';
import 'package:bdelete/model/signupModel.dart';
import 'package:bdelete/model/testModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';

class ApiServiceImpl extends ApiService {
  List<SignupModel> userList = [];
  List<LoginModel> loginList = [];
  Api api = Api();
  @override
  Future<ApiResponse> saveStudent(SignupModel signupModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("signup")
          .add(signupModel.toJson());
      return ApiResponse(networkStatus: NetworkStatus.success);
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMesssage: e.toString());
    }
  }

  @override
  Future<ApiResponse> getData() async {
    try {
      var value = await FirebaseFirestore.instance.collection("signup").get();
      userList = value.docs.map((e) => SignupModel.fromJson(e.data())).toList();
      for (int i = 0; i < userList.length; i++) {
        userList[i].id = value.docs[i].id;
      }
      return ApiResponse(networkStatus: NetworkStatus.success, data: userList);
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMesssage: e.toString());
    }
  }

  @override
  Future<ApiResponse> deleteData(String id) async {
    try {
      await FirebaseFirestore.instance.collection("signup").doc(id).delete();
      return ApiResponse(networkStatus: NetworkStatus.success);
    } catch (e) {
      return ApiResponse(
          errorMesssage: e.toString(), networkStatus: NetworkStatus.error);
    }
  }

  @override
  Future<ApiResponse> updateStudent(SignupModel signupModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("signup")
          .doc(signupModel.id)
          .update(signupModel.toJson());
      return ApiResponse(networkStatus: NetworkStatus.success);
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMesssage: e.toString());
    }
  }

  @override
  Future<ApiResponse> saveLogin(LoginModel loginModel) async {
    if (await Helper.isInternetConnectionAvailable()) {
      try {
        await FirebaseFirestore.instance
            .collection("login")
            .add(loginModel.toJson());
        return ApiResponse(networkStatus: NetworkStatus.success);
      } catch (e) {
        print(e.toString());
        return ApiResponse(
            networkStatus: NetworkStatus.error, errorMesssage: e.toString());
      }
    } else {
      return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMesssage: "No internet Connection");
    }
  }

  @override
  Future<ApiResponse> getLoginData() async {
    try {
      var value = await FirebaseFirestore.instance.collection("login").get();
      loginList = value.docs.map((e) => LoginModel.fromJson(e.data())).toList();
      for (int i = 0; i < loginList.length; i++) {
        loginList[i].id = value.docs[i].id;
      }
      return ApiResponse(networkStatus: NetworkStatus.success, data: loginList);
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMesssage: e.toString());
      print(e.toString());
    }
  }

  @override
  Future<ApiResponse> deleteLoginData(String id) async {
    try {
      await FirebaseFirestore.instance.collection("login").doc(id).delete();
      return ApiResponse(networkStatus: NetworkStatus.success);
    } catch (e) {
      print(e.toString());
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMesssage: e.toString());
    }
  }

  @override
  Future<ApiResponse> updateLogin(LoginModel loginModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("login")
          .doc(loginModel.id)
          .update(loginModel.toJson());
      return ApiResponse(networkStatus: NetworkStatus.success);
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMesssage: e.toString());
    }
  }

  @override
  Future<ApiResponse> checkLogin(LoginModel loginModel) async {
    bool isUserExists = false;
    try {
      var value = await FirebaseFirestore.instance
          .collection("login")
          .where("contact", isEqualTo: loginModel.contact)
          .where("password", isEqualTo: loginModel.password)
          .get();
      if (value.docs.isNotEmpty) {
        isUserExists = true;
      }
      return ApiResponse(
          networkStatus: NetworkStatus.success, data: isUserExists);
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMesssage: e.toString());
    }
  }

  @override
  Future<ApiResponse> task(TestModel testModel) async {
    ApiResponse apiResponse =
        await api.postApi(ApiConst.api + ApiConst.baseUrl, testModel.toJson());
    return apiResponse;
  }
}
