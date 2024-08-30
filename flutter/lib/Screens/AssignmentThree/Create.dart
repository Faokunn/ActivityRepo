import 'package:application/Screens/AssignmentThree/Read.dart';
import 'package:application/bloc/api_bloc.dart';
import 'package:application/bloc/api_event.dart';
import 'package:application/bloc/api_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateRequest extends StatefulWidget {
  const CreateRequest({super.key});

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  String? year = 'First Year';
  bool enrolled = false;
 

  late ApiBloc apiBloc;

  @override
  void initState() {
    super.initState();
    apiBloc = ApiBloc();
    apiBloc.add(studentGet());
  }

  @override
  void dispose() {
    apiBloc.close();
    super.dispose();
  }

  bool validateFields() {
    String firstName = firstNameController.toString();
    String lastName = lastNameController.toString();
    String course = courseController.toString();
    

    if (firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter first name')),
      );
      return false;
    }
    if (lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter last name')),
      );
      return false;
    }
    if (course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter course')),
      );
      return false;
    }
    if (year == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a year')),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        backgroundColor: Colors.blue,
      ),
      body: BlocProvider(
          create: (context) => apiBloc,
          child: BlocBuilder<ApiBloc, ApiState>(
            builder: (context, state) {
              if (state is studentCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Student added successfully')),
                );
              } 
              else if (state is StudentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.error}')),
                  );
              }
              return Column(children: [TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: courseController,
              decoration: const InputDecoration(labelText: 'Course'),
            ),
            DropdownButtonFormField<String>(
              value: year,
              onChanged: (String? newValue) {
                setState(() {
                  year = newValue;
                });
              },
              items: ['First Year', 'Second Year', 'Third Year', 'Fourth Year']
                  .map<DropdownMenuItem<String>>((String value) {
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
            ElevatedButton(
              onPressed: () {
                if (validateFields()) {
                  BlocProvider.of<ApiBloc>(context).add(
                    studentPost(firstNameController.text, lastNameController.text, courseController.text, year!, enrolled)
                    
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
            ],);
            }
          )
      )
    );   
  }
}
