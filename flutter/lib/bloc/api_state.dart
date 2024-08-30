import 'package:application/model/students.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class ApiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class studentEmpty extends ApiState {}

class studentCreating extends ApiState {
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  studentCreating(this.firstName, this.lastName, this.course, this.year, this.enrolled);
}

class studentCreated extends ApiState {}

class studentLoading extends ApiState {}

class studentDeleteSuccess extends ApiState {}

class specificstudentLoading extends ApiState {
  final int id;

  specificstudentLoading(this.id);
}

class StudentLoaded extends ApiState {
  final List<Students> students;
  StudentLoaded(this.students);

  @override
  List<Object?> get props => [students];
}

class SpecificStudentLoaded extends ApiState {
  final Students student;

  SpecificStudentLoaded(this.student);
}

class StudentError extends ApiState {
  final String error;
  StudentError(this.error);

  @override
  List<Object?> get props => [error];
}
