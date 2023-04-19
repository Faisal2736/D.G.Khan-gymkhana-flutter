import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final Uri url;
  Map mapresponce = {};
  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      //String data = response.body;
      mapresponce = jsonDecode(response.body);
     // return jsonDecode(data);
     // listresponce=mapresponce['data']['timings'];
      return mapresponce;
    } else {
      print(response.statusCode);
    }
  }
}