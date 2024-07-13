import 'package:bdelete/api/networkStatus.dart';

class ApiResponse {
  dynamic data;
  String? errorMesssage;
  NetworkStatus? networkStatus;
  ApiResponse({this.data, this.errorMesssage, this.networkStatus});
}
