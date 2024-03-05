import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({required this.url});

  final Uri url;

  Future getData() async {
    
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      return jsonDecode(jsonData);
    } else {
      print(response.statusCode);
    }
    
  }
}