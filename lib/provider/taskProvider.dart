import 'package:bdelete/api/apiResponse.dart';
import 'package:bdelete/api/apiService.dart';
import 'package:bdelete/api/apiServiceImpl.dart';
import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/model/testModel.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  String? email;
  String? userName;
  String? firstName;
  String? lastName,
      gender,
      profilePic,
      panNO,
      registrationNo,
      role,
      firebaseTOken;

  String? password;
  String? errorMessage;

  ApiService service = ApiServiceImpl();
  NetworkStatus _setPostApiStatus = NetworkStatus.ldel;
  NetworkStatus get getsetPostApiStatus => _setPostApiStatus;

  setPostApiStatus(NetworkStatus status) {
    _setPostApiStatus = status;
    notifyListeners();
  }

  setEmail(String value) {
    email = value;
    notifyListeners();
  }

  setFirstName(String value) {
    firstName = value;
    notifyListeners();
  }

  setLastName(String value) {
    lastName = value;
    notifyListeners();
  }

  setProfilePic(String value) {
    profilePic = value;
    notifyListeners();
  }

  setPanNo(String value) {
    panNO = value;
    notifyListeners();
  }

  setRegistration(String value) {
    registrationNo = value;
    notifyListeners();
  }

  setRole(String value) {
    role = value;
    notifyListeners();
  }

  setGender(String value) {
    gender = value;
    notifyListeners();
  }

  setUserName(String value) {
    userName = value;
    notifyListeners();
  }

  setPassword(String value) {
    password = value;
    notifyListeners();
  }

  postValueToApi() async {
    try {
        FirebaseMessaging messaging = FirebaseMessaging.instance;
          String? token = await messaging.getToken();
      TestModel testModel = TestModel(
          username: userName,
          firstname: firstName,
          lastname: lastName,
          gender: gender,
          email: email,
          password: password,
          profilePic: profilePic,
          panNo: panNO,
          registrationNo: registrationNo,
          role: role,
          firebaseToken: token
          );
      ApiResponse apiResponse = await service.task(testModel);
      if (apiResponse.networkStatus == NetworkStatus.success) {
        setPostApiStatus(NetworkStatus.success);
      } else if (apiResponse.networkStatus == NetworkStatus.error) {
        setPostApiStatus(
          NetworkStatus.error,
        );
        errorMessage = apiResponse.errorMesssage;
      }
    } catch (e) {
      print(e);
    }
  }
}
