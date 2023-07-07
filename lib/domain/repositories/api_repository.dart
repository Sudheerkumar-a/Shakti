import 'dart:async';

import 'package:shakti/domain/entities/audio_entity.dart';
import 'package:shakti/domain/entities/info_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:shakti/domain/entities/police_station_entity.dart';
import '../../core/failures.dart';

abstract class ApisRepository {
  Future<Either<Failure, List<InfoEntity>>> getInforData(
      {required String path});
  Future<Either<Failure, List<AudioEntity>>> getAudios();
  Future<Either<Failure, List<PoliceStationEntity>>> getPoliceStations();
}
