import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakti/core/utils/common_utils.dart';
import 'package:shakti/domain/entities/police_station_entity.dart';

import '../../../core/constants/app_dimension.dart';

class StationsListItem extends StatelessWidget {
  final PoliceStationEntity data;
  const StationsListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name ?? '',
                  style: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: FIVE.toDouble(),
                ),
                Text(
                  data.address ?? '',
                  style: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 134, 134, 134),
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: FIVE.toDouble(),
                ),
                Text(
                  "Distance: ${(data.distance).toStringAsFixed(1)} KM.",
                  style: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 134, 134, 134),
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              openMapsSheet(
                  context, data.name ?? '', data.lat ?? 0, data.lang ?? 0);
            },
            icon: const Icon(
              Icons.directions,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
