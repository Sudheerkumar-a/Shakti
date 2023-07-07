import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shakti/presentation/ui/widgets/audio_list_item.dart';

import '../../../domain/repositories/api_repository_impl.dart';
import '../../../domain/usecases/info_data_usecases.dart';
import '../../bloc/data_bloc.dart';
import '../widgets/app_bar.dart';

class AudioListScreen extends StatelessWidget {
  AudioListScreen({super.key});
  final ValueNotifier<String> audioLock = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DataBloc>(
      create: (context) => DataBloc(
          infoDataUsecase:
              InfoDataUsecase(repository: context.read<ApisRepositoryImpl>()))
        ..getAudios(),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppBarWidget(AppBarData(
                'HOME',
                'The pink sphere of safety & support',
                '111',
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
                } else if (state is AudiosLoadedWithSuccess) {
                  return ListView.separated(
                    itemCount: state.audiosList.length,
                    itemBuilder: (context, index) => AudioListItem(
                      audioEntity: state.audiosList[index],
                      audioLock: audioLock,
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
