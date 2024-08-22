import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/model/students.dart';

class UpdateRequest extends StatefulWidget {
  const UpdateRequest({super.key, required this.Id});

  final int Id;

  @override
  State<UpdateRequest> createState() => _UpdateRequestState();
}

class _UpdateRequestState extends State<UpdateRequest> {
  Students? student;
  bool status = false;

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  Future<void> fetchStudentData() async {
    print(widget.Id);
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/students/${widget.Id}'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> studentsJson = json.decode(response.body)['student'];
      Students students = Students.fromJson(studentsJson);

      setState(() {
        student = students;
        status = true;
      });
    } else {
      setState(() {
        status = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Assignment Three: Read"),
          backgroundColor: Colors.blue,
        ),
        body: status
            ? Column(
                children: <Widget>[
                  Text("First Name: ${student!.firstName}"),
                  Text("Last Name: ${student!.lastName}"),
                  Text("Course: ${student!.course}"),
                  Text("Year: ${student!.year}"),
                  Text("Enrolled: ${student!.enrolled.toString()}"),
                  ElevatedButton(onPressed: () {}, child: const Text("Update")),
                  ElevatedButton(onPressed: () {}, child: const Text("Delete")),
                ],
              )
            : const Center(child: Text('Failed to load students')));
  }
}
