import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakti/core/constants/assets.dart';

import '../../../domain/repositories/api_repository_impl.dart';
import '../../../domain/usecases/info_data_usecases.dart';
import '../../bloc/data_bloc.dart';
import 'item_outside_police_help.dart';

class OutsidePoliceHelp extends StatelessWidget {
  const OutsidePoliceHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DataBloc(
            infoDataUsecase:
                InfoDataUsecase(repository: context.read<ApisRepositoryImpl>()))
          ..getInfoData(path: Assets.outsidePoliceJSon),
        child: BlocBuilder<DataBloc, DataState>(
          builder: (context, state) {
            if (state is DataLoading) {
              return const CircularProgressIndicator();
            } else if (state is DataLoadedWithSuccess) {
              return Column(
                children: List.generate(
                    state.infoList.length,
                    (index) => ItemOutsidePoliceHelp(
                          index: index + 1,
                          data: state.infoList[index],
                        )),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
