import 'package:equatable/equatable.dart';
import 'package:shakti/domain/entities/audio_entity.dart';
import 'package:shakti/domain/entities/info_entity.dart';
import 'package:shakti/domain/entities/police_station_entity.dart';

class PoliceStationModel extends Equatable {
  final String? name;
  final String? address;
  final String? location;
  final double? lat;
  final double? lang;

  const PoliceStationModel(
      {this.name, this.address, this.location, this.lat, this.lang});

  factory PoliceStationModel.fromJson(Map<String, dynamic> json) {
    return PoliceStationModel(
      name: json['name'] == null ? "" : json["name"],
      address: json['address'] == null ? "" : json["address"],
      location: json['location'] == null ? "" : json["location"],
      lat: json['lat'] == null ? "" : json["lat"],
      lang: json['lang'] == null ? "" : json["lang"],
    );
  }

  @override
  List<Object?> get props => [name, address, location, lat, lang];
}

extension SourceModelExtension on PoliceStationModel {
  PoliceStationEntity get toPoliceStationEntity =>
      PoliceStationEntity(name, address, location, lat, lang);
}
