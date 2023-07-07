import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shakti/core/utils/common_utils.dart';
import 'package:shakti/domain/entities/police_station_entity.dart';
import 'package:shakti/presentation/ui/widgets/audio_list_item.dart';
import 'package:shakti/presentation/ui/widgets/stations_list_item.dart';

import '../../../domain/repositories/api_repository_impl.dart';
import '../../../domain/usecases/info_data_usecases.dart';
import '../../bloc/data_bloc.dart';
import '../widgets/app_bar.dart';
import 'package:geolocator/geolocator.dart';

class StationsListScreen extends StatefulWidget {
  StationsListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StationsListScreenState();
}

class _StationsListScreenState extends State<StationsListScreen> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DataBloc>(
      create: (context) => DataBloc(
          infoDataUsecase:
              InfoDataUsecase(repository: context.read<ApisRepositoryImpl>()))
        ..getPoliceStations(),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppBarWidget(AppBarData(
                'STATIONS',
                'The pink sphere of safety & support',
                '198',
                'Lorem ipsum, or lipsum as it is sometimes known')),
            const SizedBox(
              height: 42,
            ),
            Expanded(
              child:
                  BlocBuilder<DataBloc, DataState>(builder: (context, state) {
                if (state is DataLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is StationsLoadedWithSuccess) {
                  var data = state.stationsList;
                  if (lat.isNotEmpty) {
                    data = data
                        .map((e) => PoliceStationEntity(
                            e.name, e.address, e.location, e.lat, e.lang,
                            distance: distance(e.lat!, e.lang!,
                                double.parse(lat), double.parse(long))))
                        .toList();
                    data.sort((a, b) => a.compareTo(b));
                  }
                  return ListView.separated(
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        StationsListItem(data: data[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                  );
                } else if (state is DataLoadedWithError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
