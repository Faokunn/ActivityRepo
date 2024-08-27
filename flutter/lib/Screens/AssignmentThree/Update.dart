import 'package:application/Screens/AssignmentThree/Edit.dart';
import 'package:application/Screens/AssignmentThree/Read.dart';
import 'package:application/bloc/api_bloc.dart';
import 'package:application/bloc/api_event.dart';
import 'package:application/bloc/api_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late ApiBloc apiBloc;

  @override
  void initState(){
    super.initState();
    apiBloc = ApiBloc();
    apiBloc.add(studentShow(widget.Id));
  }

  @override
  void dispose(){
    apiBloc.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Assignment Three: Read"),
          backgroundColor: Colors.blue,
        ),
        body:  BlocProvider(create: (context) => apiBloc,
        child: BlocBuilder<ApiBloc,ApiState>(
          builder: (context, state) {
           if (state is specificstudentLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if(state is SpecificStudentLoaded){
              return Column(
                children: <Widget>[
                  Text("First Name: ${state.student.firstName}"),
                  Text("Last Name: ${state.student.lastName}"),
                  Text("Course: ${state.student.course}"),
                  Text("Year: ${state.student.year}"),
                  Text("Enrolled: ${state.student!.enrolled.toString()}"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditRequest(id: state.student.id)));
                      },
                      child: const Text("Update")),
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ApiBloc>(context).add(studentDelete(state.student.id));
                        Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => ReadRequest()));
                      },
                      child: const Text("Delete")),
                ],
              );
            }
            else if (state is StudentError) {
              return Center(child: Text(state.error));
              
            }
            else{
              return const Center(child: Text('No students available'));
            }
          }
        )
      )
    );
  }
}

/*status
            ? Column(
                children: <Widget>[
                  Text("First Name: ${student!.firstName}"),
                  Text("Last Name: ${student!.lastName}"),
                  Text("Course: ${student!.course}"),
                  Text("Year: ${student!.year}"),
                  Text("Enrolled: ${student!.enrolled.toString()}"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditRequest(id: student!.id)));
                      },
                      child: const Text("Update")),
                  ElevatedButton(
                      onPressed: () {
                        ;
                      },
                      child: const Text("Delete")),
                ],
              )
            : const Center(child: Text('Failed to load students'))); */
