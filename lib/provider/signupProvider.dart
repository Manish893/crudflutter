import 'package:bdelete/api/apiResponse.dart';
import 'package:bdelete/api/apiService.dart';
import 'package:bdelete/api/apiServiceImpl.dart';
import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/model/signupModel.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  String fullName = "";
  String address = "";
  String contact = "";
  String id = "";
  String password = "";
  String? errorMessage;
  ApiService apiService = ApiServiceImpl();
  NetworkStatus _setNetworkStatus = NetworkStatus.ldel;
  NetworkStatus get getSetNetworkStatus => _setNetworkStatus;

  List<SignupModel> userList = [];
  setloading(NetworkStatus status) {
    _setNetworkStatus = status;
    notifyListeners();
  }

  setId(String value) {
    id = value;
    notifyListeners();
  }

  setFullName(value) {
    fullName = value;
    notifyListeners();
  }

  setAddress(value) {
    address = value;
    notifyListeners();
  }

  setContact(value) {
    contact = value;
    notifyListeners();
  }

  setPassword(value) {
    password = value;
    notifyListeners();
  }

  postValueToFirebase() async {
    if (_setNetworkStatus != NetworkStatus.loading) {
      setloading(NetworkStatus.loading);
    }
    late ApiResponse response;
    
    SignupModel signupModel = SignupModel(
      id: id,
      fullName: fullName,
      address: address,
      contact: contact,
      password: password,
    );
  

    if (id.isNotEmpty) {
      response = await apiService.updateStudent(signupModel);
    } else {
      response = await apiService.saveStudent(signupModel);
    }

    if (response.networkStatus == NetworkStatus.success) {
      setloading(NetworkStatus.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      setloading(NetworkStatus.error);
      errorMessage = response.errorMesssage;
    }
  }

  NetworkStatus _getUserStatus = NetworkStatus.ldel;
  NetworkStatus get getUserStatus => _getUserStatus;
  setGetUserStatus(NetworkStatus status) {
    _getUserStatus = status;
    notifyListeners();
  }

  getValueFromFirebase() async {
    if (_getUserStatus != NetworkStatus.loading) {
      setGetUserStatus(NetworkStatus.loading);
    }
    ApiResponse response = await apiService.getData();
    if (response.networkStatus == NetworkStatus.success) {
      userList = response.data;
      setGetUserStatus(NetworkStatus.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      errorMessage = response.errorMesssage;
      setGetUserStatus(NetworkStatus.error);
    }
  }

  NetworkStatus _setDeleteStatus = NetworkStatus.ldel;
  NetworkStatus get getSetDeleteStatus => _setDeleteStatus;
  setDeleteStatus(NetworkStatus status) {
    _setDeleteStatus = status;
    notifyListeners();
  }

  deleteValueFromTable(String id) async {
    ApiResponse response = await apiService.deleteData(id);
    if (response.networkStatus == NetworkStatus.success) {
      setDeleteStatus(NetworkStatus.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      errorMessage = response.errorMesssage;
      setDeleteStatus(NetworkStatus.error);
    }
  }
}
