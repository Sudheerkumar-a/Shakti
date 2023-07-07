import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakti/core/constants/assets.dart';
import 'package:shakti/domain/usecases/info_data_usecases.dart';
import 'package:shakti/presentation/bloc/data_bloc.dart';
import 'package:shakti/presentation/ui/widgets/info_list_widget.dart';

import '../../../domain/repositories/api_repository_impl.dart';
import '../widgets/app_bar.dart';

class InfoListScreen extends StatelessWidget {
  static const route = '/InfoListScreen';
  String dataJsonPath;
  InfoListScreen({super.key, this.dataJsonPath = ''});

  AppBarData _getAppBarData(String path) {
    if (path == Assets.cyberbullyingJSon) {
      return AppBarData('CYBERBULLING', '', '222',
          'Face life with strength - you are on the right path');
    } else if (path == Assets.socialMediaHackingJSon) {
      return AppBarData('Social Media Hacking', '', '111',
          'Face life with strength - you are on the right path');
    } else if (path == Assets.backmailJSon) {
      return AppBarData('BLACKMAIL', '', '111',
          'Face life with strength - you are on the right path');
    } else if (path == Assets.stalkingJSon) {
      return AppBarData('STALKING', '', '111',
          'Face life with strength - you are on the right path');
    } else {
      return AppBarData('ABOUT US', '', '111', 'Let everything come together');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dataJsonPath.isEmpty) {
      dataJsonPath = ModalRoute.of(context)!.settings.arguments as String;
    }
    return Container(
      color: const Color.fromARGB(255, 245, 245, 245),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          AppBarWidget(_getAppBarData(dataJsonPath)),
          const SizedBox(
            height: 42,
          ),
          Expanded(
              child: InfoListWdget(
            dataJsonPath: dataJsonPath,
          )),
        ],
      ),
    );
  }
}
