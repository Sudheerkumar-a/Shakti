import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shakti/data/model/info_model.dart';
import 'package:shakti/data/model/mcq_model.dart';
import 'package:shakti/data/model/police_station_model.dart';
import 'package:shakti/domain/entities/audio_entity.dart';
import 'package:shakti/domain/entities/info_entity.dart';
import 'package:shakti/domain/entities/mcq_entity.dart';
import 'package:shakti/domain/entities/police_station_entity.dart';

import '../model/audio_model.dart';

abstract class LocalDataStore {
  Future<List<InfoEntity>> getInfoDataFromJson({required String path});
  Future<List<AudioEntity>> getAudiosFromJson({required String path});
  Future<List<PoliceStationEntity>> getPoliceStationsFromJson(
      {required String path});
        Future<List<McqEntity>> getMcqsFromJson({required String path});

}

class LocalDataStoreImpl implements LocalDataStore {
  @override
  Future<List<InfoEntity>> getInfoDataFromJson({required String path}) async {
    String data = await rootBundle.loadString(path);
    final jsonData = json.decode(data);
    final infoList = (jsonData as List)
        .map((e) => InfoModel.fromJson(e).toInfoEntity)
        .toList();
    return infoList;
  }

  @override
  Future<List<AudioEntity>> getAudiosFromJson({required String path}) async {
    String data = await rootBundle.loadString(path);
    final jsonData = json.decode(data);
    final audiosList = (jsonData as List)
        .map((e) => AudioModel.fromJson(e).toAudioEntity)
        .toList();
    return audiosList;
  }

  @override
  Future<List<PoliceStationEntity>> getPoliceStationsFromJson(
      {required String path}) async {
    String data = await rootBundle.loadString(path);
    final jsonData = json.decode(data);
    final policeStationsList = (jsonData as List)
        .map((e) => PoliceStationModel.fromJson(e).toPoliceStationEntity)
        .toList();
    return policeStationsList;
  }

  @override
  Future<List<McqEntity>> getMcqsFromJson({required String path}) async {
    String data = await rootBundle.loadString(path);
    final jsonData = json.decode(data);
    final mcqList = (jsonData as List)
        .map((e) => McqModel.fromJson(e).toMcqEntity)
        .toList();
    return mcqList;
  }
}
