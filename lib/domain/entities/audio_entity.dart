import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class AudioEntity extends Equatable {
  final id = const Uuid().v1();
  final String? title;
  final String? duration;
  final String? path;

  AudioEntity(
      {required this.title, required this.duration, required this.path});
  @override
  List<Object?> get props => [id, title, duration, path];
}
