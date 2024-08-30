import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class ApiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class studentGet extends ApiEvent {}

class studentPost extends ApiEvent {
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  studentPost(this.firstName, this.lastName, this.course, this.year, this.enrolled);
}

class studentPut extends ApiEvent {}

class studentShow extends ApiEvent {
  final int id;

  studentShow(this.id);
}

class studentDelete extends ApiEvent {
  final int id;

  studentDelete(this.id);
}
