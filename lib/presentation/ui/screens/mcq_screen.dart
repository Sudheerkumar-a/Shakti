import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakti/presentation/ui/widgets/audio_list_item.dart';

import '../../../domain/repositories/api_repository_impl.dart';
import '../../../domain/usecases/info_data_usecases.dart';
import '../../bloc/data_bloc.dart';
import '../widgets/app_bar.dart';

class McqsScreen extends StatelessWidget {
  McqsScreen({super.key});
  final ValueNotifier<int> _questionIndex = ValueNotifier<int>(0);
  final ValueNotifier<bool> _selectedAnswer = ValueNotifier<bool>(false);
  final _boxDecoration = BoxDecoration(
      color: const Color.fromARGB(255, 235, 226, 194),
      border: Border.all(color: Colors.grey),
      borderRadius: const BorderRadius.all(Radius.circular(2)));
  final _choiceTextStyle = GoogleFonts.roboto(
    color: const Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  final _choiceVerticalSpace = 5.0;
  final _choiceHorizantalSpace = 10.0;
  @override
  void dispose() {
    _questionIndex.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DataBloc>(
      create: (context) => DataBloc(
          infoDataUsecase:
              InfoDataUsecase(repository: context.read<ApisRepositoryImpl>()))
        ..getMcqs(),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppBarWidget(AppBarData(
                'PHQ-9',
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
                } else if (state is McqsLoadedWithSuccess) {
                  return ValueListenableBuilder(
                      valueListenable: _questionIndex,
                      builder: (context, value, widget) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_questionIndex.value + 1}. ",
                                  style: GoogleFonts.roboto(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    state.mcqsList[_questionIndex.value]
                                            .question ??
                                        '',
                                    style: GoogleFonts.roboto(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ValueListenableBuilder(
                                valueListenable: _selectedAnswer,
                                builder: (context, selectedAnswer, widget) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          state.mcqsList[value].answer = 1;
                                          _selectedAnswer.value =
                                              !selectedAnswer;
                                        },
                                        child: Container(
                                          decoration: _boxDecoration.copyWith(
                                              color: state.mcqsList[value]
                                                          .answer ==
                                                      1
                                                  ? Colors.green
                                                  : _boxDecoration.color),
                                          padding: EdgeInsets.symmetric(
                                              vertical: _choiceVerticalSpace,
                                              horizontal:
                                                  _choiceHorizantalSpace),
                                          child: Text(
                                            'Not at all',
                                            style: _choiceTextStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          state.mcqsList[value].answer = 2;
                                          _selectedAnswer.value =
                                              !selectedAnswer;
                                        },
                                        child: Container(
                                          decoration: _boxDecoration.copyWith(
                                              color: state.mcqsList[value]
                                                          .answer ==
                                                      2
                                                  ? Colors.green
                                                  : _boxDecoration.color),
                                          padding: EdgeInsets.symmetric(
                                              vertical: _choiceVerticalSpace,
                                              horizontal:
                                                  _choiceHorizantalSpace),
                                          child: Text(
                                            'Several days',
                                            style: _choiceTextStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          state.mcqsList[value].answer = 3;
                                          _selectedAnswer.value =
                                              !selectedAnswer;
                                        },
                                        child: Container(
                                          decoration: _boxDecoration.copyWith(
                                              color: state.mcqsList[value]
                                                          .answer ==
                                                      3
                                                  ? Colors.green
                                                  : _boxDecoration.color),
                                          padding: EdgeInsets.symmetric(
                                              vertical: _choiceVerticalSpace,
                                              horizontal:
                                                  _choiceHorizantalSpace),
                                          child: Text(
                                            'More than half the days',
                                            style: _choiceTextStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          state.mcqsList[value].answer = 4;
                                          _selectedAnswer.value =
                                              !selectedAnswer;
                                        },
                                        child: Container(
                                          decoration: _boxDecoration.copyWith(
                                              color: state.mcqsList[value]
                                                          .answer ==
                                                      4
                                                  ? Colors.green
                                                  : _boxDecoration.color),
                                          padding: EdgeInsets.symmetric(
                                              vertical: _choiceVerticalSpace,
                                              horizontal:
                                                  _choiceHorizantalSpace),
                                          child: Text(
                                            'Nearly every day',
                                            style: _choiceTextStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: _questionIndex.value > 0,
                                  maintainState: true,
                                  maintainAnimation: true,
                                  maintainSize: true,
                                  child: InkWell(
                                    onTap: () {
                                      if (_questionIndex.value > 0) {
                                        _questionIndex.value--;
                                      }
                                    },
                                    child: Container(
                                      decoration: _boxDecoration.copyWith(
                                          color: const Color.fromARGB(
                                              255, 217, 228, 238)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: _choiceVerticalSpace,
                                          horizontal: _choiceHorizantalSpace),
                                      child: Text(
                                        'PREV',
                                        style: _choiceTextStyle.copyWith(
                                            fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${value + 1} / ${state.mcqsList.length}',
                                  style:
                                      _choiceTextStyle.copyWith(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_questionIndex.value <
                                            state.mcqsList.length - 1 &&
                                        state.mcqsList[value].answer > -1) {
                                      _questionIndex.value++;
                                    }
                                  },
                                  child: Container(
                                    decoration: _boxDecoration.copyWith(
                                        color: const Color.fromARGB(
                                            255, 217, 228, 238)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: _choiceVerticalSpace,
                                        horizontal: _choiceHorizantalSpace),
                                    child: Text(
                                      value == state.mcqsList.length - 1
                                          ? 'DONE'
                                          : 'NEXT',
                                      style: _choiceTextStyle.copyWith(
                                          fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      });
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
