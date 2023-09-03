import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class InfoEntity extends Equatable {
  final id = const Uuid().v1();
  final String? title;
  final String? description;
  final String? address;
  final String? contactNumbers;

  InfoEntity(
      {required this.title,
      required this.description,
      this.address,
      this.contactNumbers});
  @override
  List<Object?> get props => [id, title, description, address, contactNumbers];
}
