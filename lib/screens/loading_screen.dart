import 'package:flutter/material.dart';
import 'package:clima_updated/services/location.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location locationService = Location();
    await locationService.getLocation();
    print(locationService.latitude);
    print(locationService.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
