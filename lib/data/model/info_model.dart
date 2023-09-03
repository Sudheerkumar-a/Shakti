import 'package:equatable/equatable.dart';
import 'package:shakti/domain/entities/info_entity.dart';

class InfoModel extends Equatable {
  final String? title;
  final String? description;
  final String? address;
  final String? contactNumbers;

  const InfoModel({
    required this.title,
    required this.description,
    this.address,
    this.contactNumbers,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      title: json['title'] == null ? "" : json["title"],
      description:
          json['description'] == null ? "Unknown" : json["description"],
      address: json['address'] == null ? "" : json["address"],
      contactNumbers:
          json['contact_numbers'] == null ? "Unknown" : json["contact_numbers"],
    );
  }

  @override
  List<Object?> get props => [title, description, address, contactNumbers];
}

extension SourceModelExtension on InfoModel {
  InfoEntity get toInfoEntity => InfoEntity(
      title: title,
      description: description,
      address: address,
      contactNumbers: contactNumbers);
}
