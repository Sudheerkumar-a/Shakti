import 'package:equatable/equatable.dart';
import '../../domain/entities/mcq_entity.dart';

class McqModel extends Equatable {
  final String? question;

  const McqModel({
    required this.question,
  });

  factory McqModel.fromJson(Map<String, dynamic> json) {
    return McqModel(
      question: json['question'] == null ? "" : json["question"],
    );
  }

  @override
  List<Object?> get props => [question];
}

extension SourceModelExtension on McqModel {
  McqEntity get toMcqEntity =>
      McqEntity(question: question,);
}
