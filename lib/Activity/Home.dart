import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = [
      "Ahmedabad",
      "Delhi",
      "Mumbai",
      "Bhavnagar",
      "Rajkot",
      "Surat"
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];

    Map info = ModalRoute
        .of(context)
        ?.settings
        ?.arguments as Map ?? {};

    String getcity = ((info['city_value']).toString());
    String icon = info['icon_value'];
    String dec = ((info["Des_value"]).toString());
    String temp = ((info['temp_value']).toString());
    String speed = ((info['Air_value']).toString());
    String hum = ((info['Hum_value']).toString());
    String rise = info['sunrise'];
    String set = info['sunset'];

    if (temp == "NA") {
      print("NA");
    } else {
      temp = ((info['temp_value']).toString().substring(0, 4));
      speed = ((info['Air_value']).toString().substring(0, 2));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.2, 0.9],
                colors: <Color>[
                  Colors.blueAccent,
                  Colors.lightBlueAccent,
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.2, 0.6],
                colors: [Colors.lightBlueAccent, Colors.blueAccent],
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", "") ==
                              "") {
                            print("Null");
                          } else {
                            Navigator.pushReplacementNamed(context, "/loc",
                                arguments: {
                                  "searchtext": searchController.text,
                                });
                          }
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          margin: EdgeInsets.fromLTRB(4, 0, 8, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $city",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.network(
                              "https://openweathermap.org/img/wn/$icon@2x.png",
                            ),
                            SizedBox(width: 18),
                            Column(
                              children: [
                                Text(
                                  "$dec".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "In $getcity",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 270,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        padding: EdgeInsets.fromLTRB(15, 30, 4, 5),
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              WeatherIcons.thermometer,
                              size: 35,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(fontSize: 103),
                                ),
                                Text(
                                  "C",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        padding: EdgeInsets.all(28),
                        height: 180,
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.cloudy_windy),
                                ]),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "$speed",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text("Km/hr"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        padding: EdgeInsets.all(28),
                        height: 180,
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.humidity),
                                ]),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "$hum",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text("Percent"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        padding: EdgeInsets.all(28),
                        height: 180,
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.sunrise),
                                ]),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "$rise",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sunrise",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        padding: EdgeInsets.all(28),
                        height: 180,
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.sunset),
                                ]),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "$set",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sunset",
                              style: TextStyle(fontWeight: FontWeight.bold


                              )
                              ,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Column(
                    children: [
                      Text("Made By Gautam", style: TextStyle(
                          fontFamily: "ft"
                      ),),
                      SizedBox(height: 10,),
                      Text(
                        "Data provided By Openweathermap.org", style: TextStyle(
                          fontFamily: "mn"
                      ),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ),
      // );

    );
  }

}

// void main() {
//   runApp(MaterialApp(home: Home()));
//}
