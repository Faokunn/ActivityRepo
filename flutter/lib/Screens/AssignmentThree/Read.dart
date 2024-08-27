import 'package:application/Screens/AssignmentThree/Create.dart';
import 'package:application/Screens/AssignmentThree/update.dart';
import 'package:application/bloc/api_bloc.dart';
import 'package:application/bloc/api_event.dart';
import 'package:application/bloc/api_state.dart';
import 'package:application/widget/CustomCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/model/students.dart';

class ReadRequest extends StatefulWidget {
  const ReadRequest({super.key});
  @override
  State<ReadRequest> createState() => _ReadRequestState();
}

class _ReadRequestState extends State<ReadRequest> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Assignment Three: Read"),
          backgroundColor: Colors.blue,
        ),
        body: BlocProvider(
          create: (context) => apiBloc,
          child: BlocBuilder<ApiBloc, ApiState>(
            builder: (context, state) {
              if (state is studentLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is StudentLoaded) {
                return ListView.builder(
                    itemCount: state.students.length,
                    itemBuilder: (context, index) {
                      final student = state.students[index];
                      return Customcard(
                          id: student.id,
                          firstName: student.firstName,
                          lastName: student.lastName,
                          enrolled: student.enrolled,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateRequest(Id: student.id),
                              ),
                            ).then((shouldRefresh) {
                              if (shouldRefresh == true) {
                                apiBloc.add(studentGet());
                              }
                            });
                          },
                          );
                    });
              } else if (state is StudentError) {
                return Center(child: Text(state.error));
              } else {
                return const Center(child: Text('No students available'));
              }
            },
          ),
        ));
  }
}

/** status
          ? studentsCollection.isEmpty
              ? const Center(child: Text('No Students Available'))
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateRequest(Id: student.id)));
                        });
                  })
          : const Center(child: Text('Failed to load students')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateRequest(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),*/
