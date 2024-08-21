import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.myController, required this.text});
  final TextEditingController myController;
  final String text;

  @override
  State<CustomTextField> createState() => _CustonTextFieldState();
}

class _CustonTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200.0,
        child: Container(
          height: 50,
          child: TextField(
            controller: widget.myController,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.greenAccent,
              fontFamily: 'monospace',
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              hintText: widget.text,
              hintStyle: const TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'monospace',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ),
    );
  }
}