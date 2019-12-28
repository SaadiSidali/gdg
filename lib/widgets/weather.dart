import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';

class Weather extends StatefulWidget {
  @override
  WeatherState createState() => WeatherState();
}

class WeatherState extends State<Weather> {
  var celcius;
  var weatherIcon;
  var location;
  WeatherStation weatherStation =
      new WeatherStation("ee40ec6e04212bedbaf8462894831927");

  Future<void> weather() async {
    var weather = await weatherStation.currentWeather();
    celcius = weather.temperature.celsius;
    weatherIcon = weather.weatherIcon;
    // print(weather);
    location = weather.areaName;
  }
  // var currentLocation;
  // var location = Location();
  // final apiKey = 'd47b9d1054b8bd623bf89e78e661fc70';
  // getWeather(lat, lon) async {
  //   final url = 'https://api.darksky.net/forecast/$apiKey/$lat,$lon';
  //   try {
  //     final response = await http.get(url);
  //     print(response.body);
  //   } catch (e) {}
  // }

  // getLocation() async {
  //   try {
  //     currentLocation = await location.getLocation();
  //   } catch (e) {
  //     if (e.code == 'PERMISSION_DENIED') {}
  //     currentLocation = null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weather(),
      builder: (_context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator(
            backgroundColor: Colors.red,
          );
        else {
          print(weatherIcon);
          return Container(
            child: WeatherWidget(
                celcius,
                Image.network(
                  'http://openweathermap.org/img/wn/$weatherIcon@2x.png',
                  fit: BoxFit.contain,
                ),
                location),
          );
        }
      },
    );
  }
}
// MY OWN 36.77072417675619 / 2.936397552630069

class WeatherWidget extends StatefulWidget {
  final double degree;
  final png;
  final String location;

  WeatherWidget(this.degree, this.png, this.location);

  @override
  WeatherWidgetState createState() => WeatherWidgetState();
}

class WeatherWidgetState extends State<WeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        // decoration: BoxDecoration(
        //   gradient: RadialGradient(
        //     colors: [Colors.white54, Colors.transparent],center: Alignment.center
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                          colors: [Colors.black26, Colors.transparent])),
                  child: widget.png,
                ),
                Container(
                  height: 40,
                  width: 3,
                  color: Colors.white,
                ),
                Text(
                  widget.degree.round().toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      shadows: [Shadow(color: Colors.black, blurRadius: 4)]),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                widget.location,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
