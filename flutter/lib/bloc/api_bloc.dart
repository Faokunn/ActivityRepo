import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/bloc/api_event.dart';
import 'package:application/bloc/api_state.dart';
import 'package:application/model/students.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(studentEmpty()) {
    on<studentGet>(fetchStudentData);
    on<studentShow>(showStudentData);
    on<studentDelete>(deleteStudentData);
  }

  Future<void> showStudentData(
      studentShow event, Emitter<ApiState> emit) async {
    emit(specificstudentLoading(event.id));

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/students/${event.id}'),
        //Uri.parse('http://localhost:8000/api/students/${widget.Id}'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> studentsJson =
            json.decode(response.body)['student'];
        Students students = Students.fromJson(studentsJson);
        emit(SpecificStudentLoaded(students));
      } else {
        emit(StudentError('Failed to load students'));
      }
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  Future<void> deleteStudentData(
      studentDelete event, Emitter<ApiState> emit) async {
    emit(specificstudentLoading(event.id));

    try {
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/api/students/${event.id}'),
        //Uri.parse('http://localhost:8000/api/students/${widget.Id}'),
      );

      if (response.statusCode == 200) {
        emit(studentDeleteSuccess());
      } else {
        emit(StudentError('Failed to delete student with ID: ${event.id}'));
      }
    } catch (e) {
      emit(StudentError('Error deleting student: ${e.toString()}'));
    }
  }

  Future<void> fetchStudentData(
      studentGet event, Emitter<ApiState> emit) async {
    emit(studentLoading());

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/students'),
        //Uri.parse('http://localhost:8000/api/students'),
      );

      if (response.statusCode == 200) {
        List<dynamic> studentsJson = json.decode(response.body)['students'];
        List<Students> students =
            studentsJson.map((json) => Students.fromJson(json)).toList();
        emit(StudentLoaded(students)); // Notebook remembers students (loaded).
      } else {
        emit(StudentError('Failed to load students'));
      }
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }
}
