import 'package:dio/dio.dart';

class StartApi {
  static String BaseUrl = "http://192.168.169.81:8000/api/";

  Dio dio = Dio(BaseOptions(baseUrl: BaseUrl));

  Future<List<dynamic>> GetImages()  async {
    try {
      print("inside GetImages");
      Response response = await dio.get('GetImages');
      print(response.data);

      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
      } else {
        print("error due to sending the request");
      }
      return [];
    }
  }
}
