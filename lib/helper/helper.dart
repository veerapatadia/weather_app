import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather.dart';

class ApiHelpers {
  ApiHelpers._();

  static final ApiHelpers apiHelper = ApiHelpers._();

  Future<Weather?> fetchData({required String Search}) async {
    final response = await http.get(
      Uri.parse(
          "https://api.weatherapi.com/v1/current.json?key=3cd73ba36dd847d98a4100033242607&q=$Search&aqi=no"),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      Weather weather = Weather.fromJson(decodedData);
      return weather;
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  }
}
