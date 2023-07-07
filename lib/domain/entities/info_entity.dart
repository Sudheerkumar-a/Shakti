import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class InfoEntity extends Equatable {
  final id = const Uuid().v1();
  final String? title;
  final String? description;

  InfoEntity({required this.title, required this.description});
  @override
  List<Object?> get props => [id, title, description];
}
