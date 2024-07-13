import 'package:bdelete/api/apiResponse.dart';
import 'package:bdelete/api/networkStatus.dart';
import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();
    postApi(String url, var data) async {
   try{
     Response response = await dio.post(url, data: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse(
          data: response.data, networkStatus: NetworkStatus.success);
    } else {
      return ApiResponse(
          networkStatus: NetworkStatus.success, errorMesssage: "Bad response");
    }
   } on DioError catch (e){
    if(e.response?.statusCode == 400 ){
      return ApiResponse(networkStatus: NetworkStatus.error,errorMesssage: e.response?.data["message"]);

    }else{
      return ApiResponse(networkStatus: NetworkStatus.error,errorMesssage: e.toString());
    }
   };
  }

}
