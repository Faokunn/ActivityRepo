import 'package:application/Screens/AssignmentThree/Read.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/model/students.dart';

class EditRequest extends StatefulWidget {
  const EditRequest({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<EditRequest> createState() => _EditRequestState();
}

class _EditRequestState extends State<EditRequest> {
  Students? student;
  bool status = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  String selectedYear = 'First Year';
  bool enrolled = false;

  final List<String> years = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
  ];

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
      Map<String, dynamic> studentJson = json.decode(response.body)['student'];
      Students student = Students.fromJson(studentJson);

      setState(() {
        this.student = student;
        firstNameController.text = student.firstName;
        lastNameController.text = student.lastName;
        courseController.text = student.course;
        selectedYear = student.year;
        enrolled = student.enrolled;
        status = true;
      });
    } else {
      setState(() {
        status = false;
      });
    }
  }

  Future<void> updateStudentData() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        courseController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/api/students/${widget.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'FirstName': firstNameController.text,
        'LastName': lastNameController.text,
        'Course': courseController.text,
        'Year': selectedYear,
        'Enrolled': enrolled,
      }),
    );
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ReadRequest()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update student')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Student"),
        backgroundColor: Colors.blue,
      ),
      body: status
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                  ),
                  TextField(
                    controller: courseController,
                    decoration: const InputDecoration(labelText: 'Course'),
                  ),
                  DropdownButton<String>(
                    value: selectedYear,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!;
                      });
                    },
                    items: years.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Row(
                    children: <Widget>[
                      Switch(
                        value: enrolled,
                        onChanged: (bool value) {
                          setState(() {
                            enrolled = value;
                          });
                        },
                      ),
                      const Text('Enrolled'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: updateStudentData,
                    child: const Text('Update'),
                  ),
                ],
              ),
            )
          : const Center(child: Text('Failed to load student')),
    );
  }
}
