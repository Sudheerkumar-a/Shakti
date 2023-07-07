import 'package:shakti/domain/usecases/info_data_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failures.dart';
import '../../domain/entities/audio_entity.dart';
import '../../domain/entities/info_entity.dart';
import '../../domain/entities/police_station_entity.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Cubit<DataState> {
  final InfoDataUsecase infoDataUsecase;
  DataBloc({required this.infoDataUsecase}) : super(DataInitial());

  Future<void> getInfoData({required String path}) async {
    emit(DataLoading());

    final result = await infoDataUsecase.getInfoData(path: path);
    emit(result.fold((l) => DataLoadedWithError(message: _getErrorMessage(l)),
        (r) => DataLoadedWithSuccess(infoList: r)));
  }

  Future<void> getAudios() async {
    emit(DataLoading());

    final result = await infoDataUsecase.getAudios();
    emit(result.fold((l) => DataLoadedWithError(message: _getErrorMessage(l)),
        (r) => AudiosLoadedWithSuccess(audiosList: r)));
  }

  Future<void> getPoliceStations() async {
    emit(DataLoading());

    final result = await infoDataUsecase.getPoliceStations();
    emit(result.fold((l) => DataLoadedWithError(message: _getErrorMessage(l)),
        (r) => StationsLoadedWithSuccess(stationsList: r)));
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      default:
        return 'An unknown error has occured';
    }
  }
}
