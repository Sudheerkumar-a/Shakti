import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakti/core/constants/app_dimension.dart';
import 'package:shakti/core/constants/assets.dart';
import 'package:shakti/presentation/ui/screens/Info_list_screen.dart';
import 'package:shakti/presentation/ui/widgets/app_bar.dart';

class ResourceScreen extends StatelessWidget {
  const ResourceScreen({super.key});
  static const route = '/ResourceScreen';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          AppBarWidget(AppBarData('SHAKTI', 'Protection', '444',
              'You are protected and guided through your journey.')),
          const SizedBox(
            height: 42,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: false).pushNamed(
                  InfoListScreen.route,
                  arguments: Assets.cyberbullyingJSon);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CYBERBULLYING',
                    style: GoogleFonts.roboto(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SvgPicture.asset(
                    Assets.cyberBullying,
                    width: FORTY.toDouble(),
                    height: FORTY.toDouble(),
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: false).pushNamed(
                  InfoListScreen.route,
                  arguments: Assets.socialMediaHackingJSon);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SOCIAL MEDIA HACKING',
                    style: GoogleFonts.roboto(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SvgPicture.asset(
                    Assets.socialMediaHacking,
                    width: FORTY.toDouble(),
                    height: FORTY.toDouble(),
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: false).pushNamed(
                  InfoListScreen.route,
                  arguments: Assets.backmailJSon);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'BLACKMAIL',
                    style: GoogleFonts.roboto(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SvgPicture.asset(
                    Assets.blackMail,
                    width: FORTY.toDouble(),
                    height: FORTY.toDouble(),
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: false).pushNamed(
                  InfoListScreen.route,
                  arguments: Assets.stalkingJSon);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'STALKING',
                    style: GoogleFonts.roboto(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SvgPicture.asset(
                    Assets.stalking,
                    width: FORTY.toDouble(),
                    height: FORTY.toDouble(),
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: false).pushNamed(
                  InfoListScreen.route,
                  arguments: Assets.revengePornJSon);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'REVENGE PORN',
                    style: GoogleFonts.roboto(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Image.asset(Assets.revengePorn,
                      width: FORTY.toDouble(),
                      height: FORTY.toDouble(),
                      fit: BoxFit.fill),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: false).pushNamed(
                  InfoListScreen.route,
                  arguments: Assets.scamAndFraudJson);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SCAM AND FRAUD',
                    style: GoogleFonts.roboto(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Image.asset(Assets.scamAndFraud,
                      width: FORTY.toDouble(),
                      height: FORTY.toDouble(),
                      fit: BoxFit.fill),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
