import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Custombutton extends StatefulWidget {
  const Custombutton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  State<Custombutton> createState() => _CustombuttonState();
}

class _CustombuttonState extends State<Custombutton> {
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(50, 50),
          textStyle: const TextStyle(fontSize: 20),
          backgroundColor: Color.fromARGB(255, 100, 100, 100),
          foregroundColor: const Color.fromARGB(255, 0, 0, 0)),
      onPressed: widget.onPressed,
      child:  Text(widget.text),
    );
  }
}