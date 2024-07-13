import 'package:bdelete/api/apiResponse.dart';
import 'package:bdelete/api/apiService.dart';
import 'package:bdelete/api/apiServiceImpl.dart';
import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/model/loginModel.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String? name;
  String? address;
  String? password;
  String? contact;
  String? id;
  ApiService apiService = ApiServiceImpl();
  NetworkStatus _setStatus = NetworkStatus.ldel;
  NetworkStatus get getStatus => _setStatus;
  NetworkStatus _setGetDataStatus = NetworkStatus.ldel;
  NetworkStatus get getDataStatus => _setGetDataStatus;
  NetworkStatus _setDeleteStatus = NetworkStatus.ldel;
  NetworkStatus get getsetDeleteStatus => _setDeleteStatus;

  NetworkStatus _getUpdateStudentStatus = NetworkStatus.ldel;
  NetworkStatus get getUpdateStudentStatus => _getUpdateStudentStatus;

  setUpdateStudentStatus(NetworkStatus status) {
    _getUpdateStudentStatus = status;
    notifyListeners();
  }

  List<LoginModel> userData = [];
  setDeleteStatus(value) {
    _setDeleteStatus = value;
    notifyListeners();
  }

  setId(value) {
    id = value;
  }

  String? errorMessage;
  setGetDataStatus(value) {
    _setGetDataStatus = value;
    notifyListeners();
  }

  setStatus(value) {
    _setStatus = value;
    notifyListeners();
  }

  setName(value) {
    name = value;
    notifyListeners();
  }

  setContact(value) {
    contact = value;
    notifyListeners();
  }

  setAddress(value) {
    address = value;
    notifyListeners();
  }

  setPasswrod(value) {
    password = value;
    notifyListeners();
  }

  postLoginValueToDataBase() async {
    if (_setStatus != NetworkStatus.loading) {
      setStatus(NetworkStatus.loading);
    }
    LoginModel loginModel = LoginModel(
        name: name,
        email: address,
        contact: contact,
        password: password,
        id: id);

    ApiResponse response = await apiService.saveLogin(loginModel);

    if (response.networkStatus == NetworkStatus.success) {
      setStatus(NetworkStatus.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      setStatus(NetworkStatus.error);
      errorMessage = response.errorMesssage;
    }
  }

  updatelogin() async {
    if (_getUpdateStudentStatus != NetworkStatus.loading) {
      setUpdateStudentStatus(NetworkStatus.loading);
    }
    LoginModel loginModel = LoginModel(
        name: name,
        email: address,
        contact: contact,
        password: password,
        id: id);
    ApiResponse apiResponse = await apiService.updateLogin(loginModel);
    if (apiResponse.networkStatus == NetworkStatus.success) {
      setUpdateStudentStatus(NetworkStatus.success);
    } else if (apiResponse.networkStatus == NetworkStatus.error) {
      setUpdateStudentStatus(NetworkStatus.error);
      errorMessage = apiResponse.errorMesssage;
    }
  }

  getValueFromFirebase() async {
    if (getDataStatus != NetworkStatus.loading) {
      setGetDataStatus(NetworkStatus.loading);
    }
    ApiResponse response = await apiService.getLoginData();
    if (response.networkStatus == NetworkStatus.success) {
      setGetDataStatus(NetworkStatus.success);
      userData = response.data;
    } else if (response.networkStatus == NetworkStatus.error) {
      setGetDataStatus(NetworkStatus.error);
      errorMessage = response.errorMesssage;
    }
  }

  deleteValueFromFireBase(String id) async {
    if (_setDeleteStatus != NetworkStatus.loading) {
      setDeleteStatus(NetworkStatus.loading);
    }
    ApiResponse apiResponse = await apiService.deleteLoginData(id);
    if (apiResponse.networkStatus == NetworkStatus.success) {
      setDeleteStatus(NetworkStatus.success);
    } else if (apiResponse.networkStatus == NetworkStatus.error) {
      errorMessage = apiResponse.errorMesssage;
      setDeleteStatus(NetworkStatus.error);
    }
  }
}
