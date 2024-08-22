import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/model/students.dart';

class UpdateRequest extends StatefulWidget {
  const UpdateRequest({super.key, required this.id});
  
  final int id;

  @override
  State<UpdateRequest> createState() => _UpdateRequestState();
}

class _UpdateRequestState extends State<UpdateRequest> {
  List<Students> student = [];
  bool status = false;

  @override
    void initState() {
      super.initState();
      fetchStudentData();
    }

  Future<void> fetchStudentData() async {
    
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/students/${widget.id}'),
    );

    if (response.statusCode == 200) {
      List<dynamic> studentsJson = json.decode(response.body)['students'];
      List<Students> students =
          studentsJson.map((json) => Students.fromJson(json)).toList();

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
    final students = student[1];
    return Scaffold( 
      appBar: AppBar(
          title: const Text("Assignment Three: Read"),
          backgroundColor: Colors.blue,
        ),
        body: status 
          ? student.isEmpty 
          ? const Center(child: Text('No Students Availbale'))
          : Column(children: <Widget>[
            
              Text("First Name: ${students.firstName}"),
              Text("Last Name: ${students.lastName}"),
              Text("Course: ${students.course}"),
              Text("Year: ${students.year}"),
              Text("Enrolled: ${students.enrolled.toString()}")
            ],
          )
        
        : const Center(child: Text('Failed to load students'))
      );
  }
}