import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: MaterialButton(
        color: Colors.blue,
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
