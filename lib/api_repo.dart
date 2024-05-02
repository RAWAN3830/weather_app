import 'dart:convert';

import 'package:http/http.dart' as http;

import 'modelclass.dart';

class apiRepo {
  WeatherModel? wm;

  Future LoadApiData(city) async {

      http.Response res = await http.get(Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=3d8fece176f54fecbf685227241104&q=${city}&days=7&aqi=yes&alerts=no'));
      print(res.body);

      var d = jsonDecode(res.body);
      // for (var e in d) {
        wm = WeatherModel.fromJson(d);
        return wm;
        // weatherList.add(wm!);
      // }

  }
}
