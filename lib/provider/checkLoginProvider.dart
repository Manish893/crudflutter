import 'package:bdelete/api/apiResponse.dart';
import 'package:bdelete/api/apiService.dart';
import 'package:bdelete/api/apiServiceImpl.dart';
import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/model/loginModel.dart';
import 'package:flutter/material.dart';

class CheckLoginProvider extends ChangeNotifier {
  String? contact;
  String? password;
  String? errorMessage;
  setContact(String value) {
    contact = value;
    notifyListeners();
  }

  setPassword(String value) {
    password = value;
    notifyListeners();
  }

  ApiService apiService = ApiServiceImpl();

  NetworkStatus _setLoginStatus = NetworkStatus.ldel;
  NetworkStatus get getSetLoginStatus => _setLoginStatus;
  setLoginStatus(NetworkStatus status) {
    _setLoginStatus = status;
    notifyListeners();
  }

  checkLogin() async {
    if (_setLoginStatus != NetworkStatus.loading) {
      setLoginStatus(NetworkStatus.loading);
    }
    LoginModel loginModel = LoginModel(
      contact: contact,
      password: password,
    );
    ApiResponse apiResponse = await apiService.checkLogin(loginModel);
    if (apiResponse.networkStatus == NetworkStatus.success) {
      setLoginStatus(NetworkStatus.success);
    } else if (apiResponse.networkStatus == NetworkStatus.error) {
      setLoginStatus(NetworkStatus.error);
      errorMessage = apiResponse.errorMesssage;
    }
  }
}
