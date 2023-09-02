import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/common_utils.dart';

class AppBarWidget extends StatelessWidget {
  final AppBarData data;
  const AppBarWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.maybePop(context);
                },
                child: Text(
                  data.title,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    letterSpacing: 4.1,
                    height: 1,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                callNumber(context, data.number);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                decoration: BoxDecoration(
                    color: const Color(0xfffccfe8),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Text(data.number,
                        style: Theme.of(context).textTheme.displayLarge),
                    Text(data.subTitle,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '',
                style: GoogleFonts.roboto(
                  color: const Color.fromARGB(255, 112, 112, 112),
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  data.caption,
                  style: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 112, 112, 112),
                    fontWeight: FontWeight.normal,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AppBarData {
  final String title;
  final String subTitle;
  final String number;
  final String caption;
  AppBarData(this.title, this.subTitle, this.number, this.caption);
}
