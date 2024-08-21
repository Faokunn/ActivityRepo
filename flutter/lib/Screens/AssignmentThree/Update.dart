import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/model/students.dart';

class UpdateRequest extends StatefulWidget {
  const UpdateRequest({super.key, required int Id});

  @override
  State<UpdateRequest> createState() => _UpdateRequestState();
}

class _UpdateRequestState extends State<UpdateRequest> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}