import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakti/core/constants/assets.dart';
import 'package:shakti/domain/usecases/info_data_usecases.dart';
import 'package:shakti/presentation/bloc/data_bloc.dart';
import 'package:shakti/presentation/ui/widgets/info_list_item.dart';

import '../../../domain/repositories/api_repository_impl.dart';
import 'app_bar.dart';

class InfoListWdget extends StatelessWidget {
  final String dataJsonPath;
  InfoListWdget({super.key, required this.dataJsonPath});
  final ValueNotifier<String> sateChangeNotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DataBloc>(
      create: (context) => DataBloc(
          infoDataUsecase:
              InfoDataUsecase(repository: context.read<ApisRepositoryImpl>()))
        ..getInfoData(path: dataJsonPath),
      child: BlocBuilder<DataBloc, DataState>(builder: (context, state) {
        if (state is DataLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DataLoadedWithSuccess) {
          return ListView.separated(
            itemCount: state.infoList.length,
            itemBuilder: (context, index) => InfoListItem(
                data: state.infoList[index],
                sateChangeNotifier: sateChangeNotifier),
            separatorBuilder: (context, index) => const SizedBox(
              height: 2,
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
    );
  }
}
