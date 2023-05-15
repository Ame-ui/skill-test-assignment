import 'package:dio/dio.dart';
import 'package:skill_test_assignment/value/api_url.dart';

class Network {
  Future<dynamic> fetchOtpCode() async {
    try {
      var response = await Dio()
          .get(otp_url, options: Options(responseType: ResponseType.bytes));
      return response;
    } catch (e) {
      if (e is DioError) {
        return e;
      }
    }
  }
}
