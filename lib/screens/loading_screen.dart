import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima_updated/services/location.dart';
import 'package:clima_updated/config_dev.dart';
import 'package:http/http.dart' as http;


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location locationService = Location();
    await locationService.getLocation();
    latitude = locationService.latitude;
    longitude = locationService.longitude;
  }

  void getWeatherData() async {
    Uri url = Uri.https('api.weatherapi.com', '/v1/current.json', {
      'key': Config.weatherApiKey,
      'q': '${latitude.toString()},${longitude.toString()}',
      'aqi': 'no',
    });
    http.Response response = await http.get(url);
    String jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    var temperature = decodedData['current']['temp_c'];
    var name = decodedData['location']['name'];
    var condition = decodedData['condition']['code'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getWeatherData();
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
