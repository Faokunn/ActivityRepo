import 'package:application/Screens/AssignmentThree/Read.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateRequest extends StatefulWidget {
  const CreateRequest({super.key});

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  String firstName = '';
  String lastName = '';
  String course = '';
  String year = 'First Year';
  bool enrolled = false;

  final List<String> years = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
  ];

  Future<void> postStudentData() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/students'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'FirstName': firstName,
        'LastName': lastName,
        'Course': course,
        'Year': year,
        'Enrolled': enrolled,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student added successfully')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ReadRequest()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add student')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'First Name'),
                  onChanged: (value) {
                    setState(() {
                      firstName = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Course'),
                  onChanged: (value) {
                    setState(() {
                      course = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter course';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: year,
                  onChanged: (String? newValue) {
                    setState(() {
                      year = newValue!;
                    });
                  },
                  items: years.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Year'),
                ),
                SwitchListTile(
                  title: const Text('Enrolled'),
                  value: enrolled,
                  onChanged: (bool value) {
                    setState(() {
                      enrolled = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: postStudentData,
        child: const Icon(Icons.check),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
