import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class McqEntity extends Equatable {
  final id = const Uuid().v1();
  final String? question;
  int answer = -1;

  McqEntity({
    required this.question,
  });
  @override
  List<Object?> get props => [id, question];
}
