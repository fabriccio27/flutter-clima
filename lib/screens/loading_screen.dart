import 'package:clima_updated/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima_updated/services/location.dart';
import 'package:clima_updated/config_dev.dart';


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
    getLocationData();
  }

  void getLocationData() async {
    Location locationService = Location();
    await locationService.getLocation();
    latitude = locationService.latitude;
    longitude = locationService.longitude;
    Uri url = Uri.https('api.weatherapi.com', '/v1/current.json', {
      'key': Config.weatherApiKey,
      'q': '${latitude.toString()},${longitude.toString()}',
      'aqi': 'no',
    });
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = await networkHelper.getData();
    /* var temperature = weatherData['current']['temp_c'];
    var name = weatherData['location']['name'];
    var condition = weatherData['condition']['code']; */   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
