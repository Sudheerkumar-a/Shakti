import 'package:dartz/dartz.dart';
import 'package:shakti/domain/entities/info_entity.dart';
import 'package:shakti/domain/entities/mcq_entity.dart';
import '../../core/failures.dart';
import '../entities/audio_entity.dart';
import '../entities/police_station_entity.dart';
import '../repositories/api_repository.dart';

class InfoDataUsecase {
  final ApisRepository repository;

  InfoDataUsecase({required this.repository});

  Future<Either<Failure, List<InfoEntity>>> getInfoData(
      {required String path}) async {
    return repository.getInforData(path: path);
  }

  Future<Either<Failure, List<AudioEntity>>> getAudios() async {
    return repository.getAudios();
  }

  Future<Either<Failure, List<PoliceStationEntity>>> getPoliceStations() async {
    return repository.getPoliceStations();
  }
  
  Future<Either<Failure, List<McqEntity>>> getMcqs() async {
    return repository.getMcqs();
  }
}
