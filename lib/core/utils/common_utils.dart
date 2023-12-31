import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';
Future<void> openMapsSheet(BuildContext context, String title, double lat, double lang) async {
    try {
     final availableMaps = await MapLauncher.installedMaps;
     if(availableMaps.length>1){
     if(context.mounted) {
       showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: ListTile(
                        onTap: () => map.showMarker(
                          coords: Coords(lat, lang),
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
     }
    }else{
      await availableMaps.first.showMarker(
    coords: Coords(lat, lang),
    title: title,
  );
    }
    } catch (e) {
      print(e);
    }
  }
Future<void> launchMapUrl(
    BuildContext context, String title, double lat, double long) async {
  final availableMaps = await MapLauncher.installedMaps;
  await availableMaps.first.showMarker(
    coords: Coords(lat, long),
    title: title,
  );
}

callNumber(BuildContext context, String number) async {
  final result = await FlutterPhoneDirectCaller.callNumber(number);
  if (result == false && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(child: Text('could_not_launch_this_app')),
    ));
  }
}

double distance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371;
  final dLat = deg2rad(lat2 - lat1);
  final dLon = deg2rad(lon2 - lon1);
  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final d = R * c;
  return d;
}

double deg2rad(deg) {
  return deg * (pi / 180);
}
