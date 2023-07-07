import 'package:equatable/equatable.dart';
import 'package:shakti/domain/entities/audio_entity.dart';
import 'package:shakti/domain/entities/info_entity.dart';

class AudioModel extends Equatable {
  final String? title;
  final String? duration;
  final String? path;

  const AudioModel(
      {required this.title, required this.duration, required this.path});

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      title: json['title'] == null ? "" : json["title"],
      duration: json['duration'] == null ? "" : json["duration"],
      path: json['path'] == null ? "" : json["path"],
    );
  }

  @override
  List<Object?> get props => [title, duration, path];
}

extension SourceModelExtension on AudioModel {
  AudioEntity get toAudioEntity =>
      AudioEntity(title: title, duration: duration, path: path);
}
