import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  static const String _apiKey = '970242d9e88fb1e81c33d2d10e2a6848';
  static const String _baseUrl = 'https://home.openweathermap.org//data/2.5/weather';

  Future<Weather> fetchWeather(String cityName) async {
    final uri = Uri.parse('$_baseUrl?q=$cityName&units=metric&appid=$_apiKey');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      final message = errorBody['message'] ?? 'Unable to fetch weather data';
      throw Exception('Error: $message');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return Weather.fromJson(json);
  }
}
