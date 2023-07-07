import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shakti/core/constants/assets.dart';
import 'package:shakti/data/datasource/local_data_source.dart';
import 'package:shakti/domain/entities/audio_entity.dart';
import 'package:shakti/domain/entities/info_entity.dart';
import 'package:shakti/domain/entities/police_station_entity.dart';

import '../../core/failures.dart';
import 'api_repository.dart';

class ApisRepositoryImpl implements ApisRepository {
  final LocalDataStore localDataSource;

  ApisRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<InfoEntity>>> getInforData(
      {required String path}) async {
    try {
      final infoData = await localDataSource.getInfoDataFromJson(path: path);
      return Right(infoData);
    } catch (error) {
      return Left(JsonFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AudioEntity>>> getAudios() async {
    try {
      final audiosData =
          await localDataSource.getAudiosFromJson(path: Assets.audiosJSon);
      return Right(audiosData);
    } catch (error) {
      return Left(JsonFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PoliceStationEntity>>> getPoliceStations() async {
    try {
      final stations = await localDataSource.getPoliceStationsFromJson(
          path: Assets.policeStationsJSon);
      return Right(stations);
    } catch (error) {
      return Left(JsonFailure(message: error.toString()));
    }
  }
}
