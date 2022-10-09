// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shopping/models/BoardingModel.dart';

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((ele) => print(ele.group(0)));
}

String token = '';


Future<bool> checkConnection() async{
  try{
    final result = await InternetAddress.lookup('google.com');
    var res = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    if(res){
      print("you connect with internet");
      return true;
    }
    print("you not connect with internet");
    return false;
  } on SocketException catch(err){
    print("you not connect with internet");
    return false;
  }
}

Widget offline(){
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          'Loss Connection',
          style: TextStyle(
            color: Colors.black12,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}


Widget dataEmpty(String text){
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(45.0),
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 2.0, color: Colors.black26),
        ),
        height: 200.0,
        width: 500.0,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 22.0,
              color: Colors.black12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}