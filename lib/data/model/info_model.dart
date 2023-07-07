import 'package:equatable/equatable.dart';
import 'package:shakti/domain/entities/info_entity.dart';

class InfoModel extends Equatable {
  final String? title;
  final String? description;

  const InfoModel({
    required this.title,
    required this.description,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      title: json['title'] == null ? "" : json["title"],
      description:
          json['description'] == null ? "Unknown" : json["description"],
    );
  }

  @override
  List<Object?> get props => [title, description];
}

extension SourceModelExtension on InfoModel {
  InfoEntity get toInfoEntity =>
      InfoEntity(title: title, description: description);
}
