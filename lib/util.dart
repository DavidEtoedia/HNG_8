import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.black),
      child: const Center(
          child: Text(
        'Please accept terms and conditions',
        style: TextStyle(fontSize: 16, color: Colors.white),
      )),
    );
  }
}
