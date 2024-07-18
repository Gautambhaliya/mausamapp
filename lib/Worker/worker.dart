import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class worker
{

   String? location;

  //Constructor

  worker({this.location})
  {
    location = this.location;
  }

  String? temp;
  String? humidity;
  String? air_speed;
  String? description;
  String? main;
  String? icon;
  String? sunset;
  String? sunrise;

   Future<void> getData() async
   {
try{
   //method =

   Response response =await get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$location""&appid=e34a5eb0b4c5ff748fdf9219a63d224e"));
   Map data = jsonDecode(response.body);

   //Getting Temp,Humidiy
   Map temp_data = data['main'];
   String getHumidity = temp_data['humidity'].toString();
   double getTemp = temp_data['temp']-273.15;

//Getting air_speed
   Map wind = data['wind'];
   double getAir_speed = wind["speed"]*3.6;// .toStringAsFixed(2);
  // air_speed = (responseData['wind']['speed'] * 3.6).toStringAsFixed(2);

   //Getting Description
   List weather_data = data['weather'];
   Map weather_main_data = weather_data[0];
   String getMain_des = weather_main_data['main'];
   String getDesc = weather_main_data["description"];

   //Getting time


  Map time_data=data['sys'];
  int get_sunrise=time_data['sunrise'];
  int get_sunset=time_data['sunset'];

  int sunrize_formate = get_sunrise; // Example Unix timestamp
  DateTime get_sunrise_format = DateTime.fromMillisecondsSinceEpoch(sunrize_formate * 1000);
  String sunrise_f = DateFormat('hh:mm a').format(get_sunrise_format);

  int sunset_formate = get_sunset; // Example Unix timestamp
  DateTime get_sunset_format = DateTime.fromMillisecondsSinceEpoch(sunset_formate * 1000);
  String sunset_f = DateFormat('hh:mm a').format(get_sunset_format);


  //Assigning Values
   temp = getTemp.toString();
   humidity = getHumidity;
   air_speed = getAir_speed.toString();
   description = getDesc;
   main = getMain_des;
  icon = weather_main_data["icon"].toString();
  sunrise = sunrise_f.toString();
  sunset = sunset_f.toString();

// print(air_speed);
  print(data);

print(sunrise);
print(sunset);

   }catch(e){
  temp = "NA";
  humidity ="NA";
  air_speed ="NA";
  description ="Can't find Data";
  main ="NA";
  sunrise="NA";
  sunset="NA";
  icon="03n";

  print("*************Error************=$e");

   }




   }

}