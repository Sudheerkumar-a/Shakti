import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/repositories/api_repository_impl.dart';
import '../../../domain/usecases/info_data_usecases.dart';
import '../../bloc/data_bloc.dart';
import '../widgets/app_bar.dart';

class McqsScreen extends StatelessWidget {
  McqsScreen({super.key});
  final ValueNotifier<int> _questionIndex = ValueNotifier<int>(0);
  final ValueNotifier<bool> _selectedAnswer = ValueNotifier<bool>(false);
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
                        if (_questionIndex.value == 9) {
                          return Column(
                            children: [
                              Text(
                                'Successfully Submitted',
                                style: GoogleFonts.roboto(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 30,),
                              InkWell(
                                onTap: () {
                                  _questionIndex.value = 0;
                                },
                                child: Container(
                                  decoration: _boxDecoration.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: _choiceHorizantalSpace),
                                  child: Text(
                                    'Restart',
                                    style: _choiceTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration:
                                  _boxDecoration.copyWith(color: Colors.white),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          state.mcqsList[_questionIndex.value]
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
                                      builder:
                                          (context, selectedAnswer, widget) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                state.mcqsList[value].answer =
                                                    1;
                                                _selectedAnswer.value =
                                                    !selectedAnswer;
                                              },
                                              child: Container(
                                                decoration: _boxDecoration,
                                                padding: EdgeInsets.symmetric(
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
                                                              horizontal: -4,
                                                              vertical: -4),
                                                      shape:
                                                          const CircleBorder(),
                                                      value: state
                                                              .mcqsList[value]
                                                              .answer ==
                                                          1,
                                                      onChanged: (value) {},
                                                    ),
                                                    Text(
                                                      'Not at all',
                                                      style: _choiceTextStyle,
                                                      textAlign:
                                                          TextAlign.center,
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
                                                state.mcqsList[value].answer =
                                                    2;
                                                _selectedAnswer.value =
                                                    !selectedAnswer;
                                              },
                                              child: Container(
                                                decoration: _boxDecoration,
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
                                                              horizontal: -4,
                                                              vertical: -4),
                                                      shape:
                                                          const CircleBorder(),
                                                      value: state
                                                              .mcqsList[value]
                                                              .answer ==
                                                          2,
                                                      onChanged: (value) {},
                                                    ),
                                                    Text(
                                                      'Several days',
                                                      style: _choiceTextStyle,
                                                      textAlign:
                                                          TextAlign.center,
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
                                                state.mcqsList[value].answer =
                                                    3;
                                                _selectedAnswer.value =
                                                    !selectedAnswer;
                                              },
                                              child: Container(
                                                decoration: _boxDecoration,
                                                padding: EdgeInsets.symmetric(
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
                                                              horizontal: -4,
                                                              vertical: -4),
                                                      shape:
                                                          const CircleBorder(),
                                                      value: state
                                                              .mcqsList[value]
                                                              .answer ==
                                                          3,
                                                      onChanged: (value) {},
                                                    ),
                                                    Text(
                                                      'More than half the days',
                                                      style: _choiceTextStyle,
                                                      textAlign:
                                                          TextAlign.center,
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
                                                state.mcqsList[value].answer =
                                                    4;
                                                _selectedAnswer.value =
                                                    !selectedAnswer;
                                              },
                                              child: Container(
                                                decoration: _boxDecoration,
                                                padding: EdgeInsets.symmetric(
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
                                                              horizontal: -4,
                                                              vertical: -4),
                                                      shape:
                                                          const CircleBorder(),
                                                      value: state
                                                              .mcqsList[value]
                                                              .answer ==
                                                          4,
                                                      onChanged: (value) {},
                                                    ),
                                                    Text(
                                                      'Nearly every day',
                                                      style: _choiceTextStyle,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  style:
                                      _choiceTextStyle.copyWith(fontSize: 14),
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
                                                left: Radius.circular(10))),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: _choiceHorizantalSpace),
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
                                        state.mcqsList[value].answer > -1) {
                                      _questionIndex.value++;
                                    }
                                  },
                                  child: Container(
                                    decoration: _boxDecoration.copyWith(
                                        color: Colors.white,
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                right: Radius.circular(10))),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: _choiceHorizantalSpace),
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
                            Visibility(
                              visible: _questionIndex.value == 8,
                              child: InkWell(
                                onTap: () {
                                  _questionIndex.value = 9;
                                },
                                child: Container(
                                  decoration: _boxDecoration.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: _choiceHorizantalSpace),
                                  child: Text(
                                    'Submit',
                                    style: _choiceTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
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
}
