import 'package:flutter/material.dart';
import 'page3.dart';


class Reservation{

  int price;
  String roomtype;


  Reservation({required this.roomtype,required this.price});

  //toString method USED TO DISPLAY AN ITEM IN A DROPDOWN WIDGET
  @override
  String toString(){
    return '$roomtype Room Price per night: \$$price';
  }


}





