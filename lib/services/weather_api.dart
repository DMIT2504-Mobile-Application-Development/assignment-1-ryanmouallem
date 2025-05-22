import 'dart:convert';

import 'package:http/http.dart' as http;

const String weatherApiKey = '681609fde011e6551ccd5eae0a3f0b91';

const String currentWeatherEndpoint = 'https://api.openweathermap.org/data/2.5/weather';

Future<dynamic> getWeatherForCity({required String city}) async {
  final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?units=metric&q=$city&appid=$weatherApiKey');
  final response = await http.get(url);

  try {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
        'There was a problem with the request: status '
            '${response.statusCode} received'
    );
  } catch (e) {
    throw Exception('There was a problem with the request: $e');
  }
}


