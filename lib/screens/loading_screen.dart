import 'package:clima_updated/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima_updated/services/location.dart';
import 'package:clima_updated/config_dev.dart';
import 'package:clima_updated/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


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
    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(locationWeather: weatherData,)));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.white, size: 100.0),
      ),
    );
  }
}
