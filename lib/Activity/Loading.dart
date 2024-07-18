import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:mausam/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city = "Bhavnagar";
  String? temp;
  String? hum;
  String? air_speed;
  String? des;
  String? main;
  String? icon;
  String? sun_r;
  String? sun_s;

  void startApp(String city) async {
    worker instance = worker(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;
    sun_r=instance.sunrise;
    sun_s=instance.sunset;

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "Hum_value": hum,
        "Air_value": air_speed,
        "Des_value": des,
        "Main_value": main,
        "icon_value": icon,
        "city_value": city,
        "sunrise": sun_r,
        "sunset":sun_s,

      });
    });
  }

  @override
  void initState() {
    super.initState();

    // Check for arguments after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map search = ModalRoute.of(context)?.settings?.arguments as Map? ?? {};
      if (search.isNotEmpty) {
        city = search['searchtext'];
      }
      startApp(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 4),
                Image.asset("img/a.jpg", height: 450, width: 250),
                // SizedBox(height:0 ,),
                Text(
                  "Mausam App",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white60,
                    fontFamily: "mn",
                  ),
                ),
                SizedBox(height: 28),
                LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(height: 80),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      textAlign: TextAlign.center,
                      "Create by Gautam",
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "ft",

                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
