import 'package:clima_updated/config_dev.dart';
import 'package:clima_updated/services/location.dart';
import 'package:clima_updated/services/networking.dart';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location locationService = Location();
    await locationService.getLocation();
    Uri url = Uri.https('api.weatherapi.com', '/v1/current.json', {
      'key': Config.weatherApiKey,
      'q': '${locationService.latitude.toString()},${locationService.longitude.toString()}',
      'aqi': 'no',
    });
    NetworkHelper networkHelper = NetworkHelper(url: url);
    return await networkHelper.getData();
  }
}
