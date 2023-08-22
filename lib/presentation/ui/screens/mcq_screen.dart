// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/mcq_entity.dart';
import '../../../domain/repositories/api_repository_impl.dart';
import '../../../domain/usecases/info_data_usecases.dart';
import '../../bloc/data_bloc.dart';
import '../widgets/app_bar.dart';

class McqsScreen extends StatelessWidget {
  McqsScreen({super.key});
  final ValueNotifier<String> _testResult = ValueNotifier<String>('');
  int finalScore = 0;
  late SharedPreferences prefs;
  final ValueNotifier<int> _questionIndex = ValueNotifier<int>(0);
  final ValueNotifier<bool> _selectedAnswer = ValueNotifier<bool>(false);
  List<McqEntity> mcqsList = [];
  final _boxDecoration = BoxDecoration(
      color: const Color.fromARGB(255, 245, 245, 245),
      border: Border.all(color: Colors.transparent),
      borderRadius: const BorderRadius.all(Radius.circular(5)));
  final _choiceTextStyle = GoogleFonts.roboto(
    color: const Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  final _choiceVerticalSpace = 0.0;
  final _choiceHorizantalSpace = 10.0;
  @override
  void dispose() {
    _questionIndex.dispose();
  }

  _getTestResult() async {
    prefs = await SharedPreferences.getInstance();
    finalScore = prefs.getInt("finalScore") ?? 0;
    _testResult.value = prefs.getString("testResult") ?? '';
  }

  _caluculateScore() {
    finalScore = 0;
    for (int i = 0; i < mcqsList.length; i++) {
      finalScore = finalScore + (mcqsList[i].answer - 1);
    }
  }

  _setTestResult() async {
    prefs.setString("testResult", '');
    var testResult = '';
    if (finalScore <= 4) {
      testResult =
          'Scoring between 0 and 4 indicates minimal or no symptoms of depression. While occasional feelings of sadness or stress are a natural part of life, the absence of significant depressive symptoms suggests a healthy emotional state. However, it is essential to continue monitoring one\'s mental well-being and practice self-care to maintain good mental health.';
    } else if (finalScore <= 9) {
      testResult =
          'Scoring between 5 and 9 reveals that mild symptoms of depression appear to exist, which might warrant closer observation and reevaluation after a certain period of time.';
    } else if (finalScore <= 14) {
      testResult =
          'Scoring between 10-14 means that you have a moderate severity depression, with numbers in this range generally leading to recommendations for medication or psychotherapy.';
    } else if (finalScore <= 19) {
      testResult =
          'Scoring between 15 and 19 suggests that there is possibly moderately severe major depression, either antidepressants or psychotherapy would likely be appropriate.';
    } else {
      testResult =
          'A score of 20 or higher indicates that severe major depression likely exists and a combination of antidepressant medication and psychotherapy (therapeutic counseling) may be the best treatment approach.';
    }
    prefs.setString("testResult", testResult);
    prefs.setInt("finalScore", finalScore);
    _testResult.value = testResult;
  }

  _resetTestResult() async {
    prefs.setString("finalScore", '');
    prefs.setString("testResult", '');
    _testResult.value = '';
  }

  @override
  Widget build(BuildContext context) {
    _getTestResult();
    return ValueListenableBuilder(
      valueListenable: _testResult,
      builder: (context, value, child) {
        if (value.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.all(20),
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
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: _boxDecoration.copyWith(color: Colors.white),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 98, 38, 58),
                            border: Border.all(width: 4, color: Colors.pink),
                            shape: BoxShape.circle),
                        child: Column(
                          children: [
                            Text(
                              '$finalScore',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              'Your Score',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        value,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    _questionIndex.value = 0;
                    _resetTestResult();
                  },
                  child: Container(
                    decoration: _boxDecoration.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      'Restart',
                      style: _choiceTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return BlocProvider<DataBloc>(
            create: (context) => DataBloc(
                infoDataUsecase: InfoDataUsecase(
                    repository: context.read<ApisRepositoryImpl>()))
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
                    child: BlocBuilder<DataBloc, DataState>(
                        builder: (context, state) {
                      if (state is DataLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is McqsLoadedWithSuccess) {
                        mcqsList = state.mcqsList;
                        return ValueListenableBuilder(
                            valueListenable: _questionIndex,
                            builder: (context, value, widget) {
                              return Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: _boxDecoration.copyWith(
                                        color: Colors.white),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_questionIndex.value + 1}. ",
                                              style: GoogleFonts.roboto(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                state
                                                        .mcqsList[_questionIndex
                                                            .value]
                                                        .question ??
                                                    '',
                                                style: GoogleFonts.roboto(
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontWeight: FontWeight.w500,
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
                                            builder: (context, selectedAnswer,
                                                widget) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      state.mcqsList[value]
                                                          .answer = 1;
                                                      _selectedAnswer.value =
                                                          !selectedAnswer;
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          _boxDecoration,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical:
                                                            _choiceVerticalSpace,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Checkbox(
                                                            visualDensity:
                                                                const VisualDensity(
                                                                    horizontal:
                                                                        -4,
                                                                    vertical:
                                                                        -4),
                                                            shape:
                                                                const CircleBorder(),
                                                            value: state
                                                                    .mcqsList[
                                                                        value]
                                                                    .answer ==
                                                                1,
                                                            onChanged:
                                                                (value) {},
                                                          ),
                                                          Text(
                                                            'Not at all',
                                                            style:
                                                                _choiceTextStyle,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      state.mcqsList[value]
                                                          .answer = 2;
                                                      _selectedAnswer.value =
                                                          !selectedAnswer;
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          _boxDecoration,
                                                      padding: EdgeInsets.symmetric(
                                                          vertical:
                                                              _choiceVerticalSpace),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Checkbox(
                                                            visualDensity:
                                                                const VisualDensity(
                                                                    horizontal:
                                                                        -4,
                                                                    vertical:
                                                                        -4),
                                                            shape:
                                                                const CircleBorder(),
                                                            value: state
                                                                    .mcqsList[
                                                                        value]
                                                                    .answer ==
                                                                2,
                                                            onChanged:
                                                                (value) {},
                                                          ),
                                                          Text(
                                                            'Several days',
                                                            style:
                                                                _choiceTextStyle,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      state.mcqsList[value]
                                                          .answer = 3;
                                                      _selectedAnswer.value =
                                                          !selectedAnswer;
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          _boxDecoration,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical:
                                                            _choiceVerticalSpace,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Checkbox(
                                                            visualDensity:
                                                                const VisualDensity(
                                                                    horizontal:
                                                                        -4,
                                                                    vertical:
                                                                        -4),
                                                            shape:
                                                                const CircleBorder(),
                                                            value: state
                                                                    .mcqsList[
                                                                        value]
                                                                    .answer ==
                                                                3,
                                                            onChanged:
                                                                (value) {},
                                                          ),
                                                          Text(
                                                            'More than half the days',
                                                            style:
                                                                _choiceTextStyle,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      state.mcqsList[value]
                                                          .answer = 4;
                                                      _selectedAnswer.value =
                                                          !selectedAnswer;
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          _boxDecoration,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical:
                                                            _choiceVerticalSpace,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Checkbox(
                                                            visualDensity:
                                                                const VisualDensity(
                                                                    horizontal:
                                                                        -4,
                                                                    vertical:
                                                                        -4),
                                                            shape:
                                                                const CircleBorder(),
                                                            value: state
                                                                    .mcqsList[
                                                                        value]
                                                                    .answer ==
                                                                4,
                                                            onChanged:
                                                                (value) {},
                                                          ),
                                                          Text(
                                                            'Nearly every day',
                                                            style:
                                                                _choiceTextStyle,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(
                                        flex: 2,
                                      ),
                                      Text(
                                        '${value + 1} / ${state.mcqsList.length}',
                                        style: _choiceTextStyle.copyWith(
                                            fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          if (_questionIndex.value > 0) {
                                            _questionIndex.value--;
                                          }
                                        },
                                        child: Container(
                                          decoration: _boxDecoration.copyWith(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                      left:
                                                          Radius.circular(10))),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal:
                                                  _choiceHorizantalSpace),
                                          child: Icon(
                                            Icons.chevron_left,
                                            color: _questionIndex.value == 0
                                                ? const Color.fromARGB(
                                                    255, 233, 231, 231)
                                                : null,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_questionIndex.value <
                                                  state.mcqsList.length - 1 &&
                                              state.mcqsList[value].answer >
                                                  -1) {
                                            _questionIndex.value++;
                                          }
                                        },
                                        child: Container(
                                          decoration: _boxDecoration.copyWith(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                      right:
                                                          Radius.circular(10))),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal:
                                                  _choiceHorizantalSpace),
                                          child: Icon(
                                            Icons.chevron_right,
                                            color: _questionIndex.value == 8
                                                ? const Color.fromARGB(
                                                    255, 233, 231, 231)
                                                : null,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: _selectedAnswer,
                                      builder: (context, value, widget) {
                                        return Visibility(
                                          visible: (_questionIndex.value == 8 &&
                                              mcqsList[8].answer > 0),
                                          child: InkWell(
                                            onTap: () {
                                              _caluculateScore();
                                              _setTestResult();
                                            },
                                            child: Container(
                                              decoration:
                                                  _boxDecoration.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  5))),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal:
                                                      _choiceHorizantalSpace),
                                              child: Text(
                                                'Submit',
                                                style:
                                                    _choiceTextStyle.copyWith(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                  const SizedBox(
                                    height: 30,
                                  ),
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
      },
    );
  }
}
