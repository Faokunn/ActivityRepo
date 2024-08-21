import 'dart:ffi';
import 'package:application/Screens/AssignmentThree/update.dart';
import 'package:application/widget/CustomCard.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/model/students.dart';

class ReadRequest extends StatefulWidget {
  const ReadRequest({super.key});
  @override
  State<ReadRequest> createState() => _ReadRequestState();
}

class _ReadRequestState extends State<ReadRequest> {
  List<Students> studentsCollection = [];
  bool status = false;

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  Future<void> fetchStudentData() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/students'),
    );

    if (response.statusCode == 200){
      List<dynamic> studentsJson = json.decode(response.body)['data'];
      List<Students> students = studentsJson.map((json) => Students.fromJson(json)).toList();

      setState(() {
        studentsCollection = students;
        status = true;
      });
    }
    else{
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
        ? studentsCollection.isEmpty 
          ? const Center(child: Text('No Students Availbale'))
          : ListView.builder(
            itemCount: studentsCollection.length,
            itemBuilder: (context, index) {
              final student = studentsCollection[index];
              return Customcard(
                id: student.id,
                firstName: student.firstName, 
                lastName: student.lastName, 
                enrolled: student.enrolled, 
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateRequest( Id : student.id)));
                }
              );
            }
          )
        : const Center(child: Text('Failed to load students'))
                
            
    );
  }
}