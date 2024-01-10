import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';
import 'login.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


const String _baseURL = 'ayasaatiliu.000webhostapp.com';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: 'MyApp',
        routes: {
          '/Page1': (context) => Page1(),
          '/Page2': (context) => Page2(),
          '/LoginPage': (context) => LoginPage(),
        },
        debugShowCheckedModeBanner: false,
        title:'Grand Horizon',
        home:Page1()
    );
  }
}

