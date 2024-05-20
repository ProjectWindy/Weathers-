import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/weather_model.dart';
import 'package:flutter_application_3/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}
String getWeatherAnimation(String? mainCondition){
  if (mainCondition == null) return 'assets/Sun.json';
  switch(mainCondition.toLowerCase()){
    case 'clouds':
    case 'smoke':
    case 'haze':
    case 'fog': return 'assets/Cloud.json';
    case 'shower rain': return 'assets/Rain.json';
    case 'Lighining': return 'assets/Thunder.json';
    case 'clear ' : return 'assets/Sun.json';
    default : return 'assets/Sun.json';
  }
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('07f1ce80a826e88056624a902310b965');
  Weather ? _weather;
  _fetchWeather()async{
    String cityName = await _weatherService.getCurrentCity();
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }
  @override
  void initState() {
     super.initState();
     _fetchWeather();
  }
    @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "Loading city",),

            // Animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),



            Text("${_weather?.temperature.round()}^C"),
             
      // Weather condition 
            Text(_weather?.mainCondition ?? '')

          ],
        ),
      ),
    );
  }
}