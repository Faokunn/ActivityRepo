import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class ApiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class studentGet extends ApiEvent {}

class studentPost extends ApiEvent {}

class studentPut extends ApiEvent {}

class studentShow extends ApiEvent {
  final int id;

  studentShow(this.id);
}

class studentDelete extends ApiEvent {}
