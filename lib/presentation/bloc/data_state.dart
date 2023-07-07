part of 'data_bloc.dart';

abstract class DataState extends Equatable {}

class DataInitial extends DataState {
  @override
  List<Object?> get props => [];
}

class DataLoading extends DataState {
  @override
  List<Object?> get props => [];
}

class DataLoadedWithSuccess extends DataState {
  final List<InfoEntity> infoList;

  DataLoadedWithSuccess({required this.infoList});
  @override
  List<Object?> get props => [infoList];
}

class AudiosLoadedWithSuccess extends DataState {
  final List<AudioEntity> audiosList;

  AudiosLoadedWithSuccess({required this.audiosList});
  @override
  List<Object?> get props => [audiosList];
}

class StationsLoadedWithSuccess extends DataState {
  final List<PoliceStationEntity> stationsList;

  StationsLoadedWithSuccess({required this.stationsList});
  @override
  List<Object?> get props => [stationsList];
}

class DataLoadedWithError extends DataState {
  final String message;

  DataLoadedWithError({required this.message});
  @override
  List<Object?> get props => [message];
}
