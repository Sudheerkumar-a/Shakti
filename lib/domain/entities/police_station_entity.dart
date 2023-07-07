import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class PoliceStationEntity extends Equatable
    implements Comparable<PoliceStationEntity> {
  final id = const Uuid().v1();
  final String? name;
  final String? address;
  final String? location;
  final double? lat;
  final double? lang;
  final double distance;

  PoliceStationEntity(
      this.name, this.address, this.location, this.lat, this.lang,
      {this.distance = 0});
  @override
  List<Object?> get props => [id, name, address, location, lat, lang];

  @override
  int compareTo(PoliceStationEntity other) =>
      distance.compareTo(other.distance);
}
