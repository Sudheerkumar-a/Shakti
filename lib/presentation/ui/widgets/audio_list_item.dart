import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shakti/core/constants/app_dimension.dart';
import 'package:shakti/core/constants/colors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shakti/domain/entities/audio_entity.dart';
import 'package:shakti/presentation/ui/widgets/seek_bar.dart';

class AudioListItem extends StatefulWidget {
  final AudioEntity audioEntity;
  final ValueNotifier<String> audioLock;
  const AudioListItem({
    super.key,
    required this.audioEntity,
    required this.audioLock,
  });
  @override
  State<StatefulWidget> createState() => _AudioListItemState();
}

class _AudioListItemState extends State<AudioListItem>
    with TickerProviderStateMixin {
  ValueNotifier<String> get _audioLock => widget.audioLock;
  final AudioPlayer _player = AudioPlayer();
  bool isPlayClicked = false;

  void onAudioLockChange() {
    if (_audioLock.value != widget.audioEntity.id) {
      _player.pause();
      isPlayClicked = false;
      //setState(() {});
    }
  }

  void initAudio() {
    _audioLock.addListener(onAudioLockChange);
    _player.setLoopMode(LoopMode.off);
  }

  @override
  void initState() {
    initAudio();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _player.setAudioSource(
        AudioSource.uri(Uri.parse(widget.audioEntity.path ?? '')));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: TWENTY.toDouble()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.audioEntity.title ?? '',
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
                            '49 min 45 sec',
                            style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 134, 134, 134),
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: true,
                      maintainState: true,
                      maintainAnimation: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<Duration?>(
                            stream: _player.durationStream,
                            builder: (context, snapshot) {
                              final duration = snapshot.data ?? Duration.zero;
                              return StreamBuilder<PositionData>(
                                stream: Rx.combineLatest2<Duration, Duration,
                                        PositionData>(
                                    _player.positionStream,
                                    _player.bufferedPositionStream,
                                    (position, bufferedPosition) =>
                                        PositionData(
                                            position, bufferedPosition)),
                                builder: (context, snapshot) {
                                  final positionData = snapshot.data ??
                                      PositionData(
                                          Duration.zero, Duration.zero);
                                  var position = positionData.position;
                                  if (position > duration) {
                                    position = duration;
                                  }
                                  var bufferedPosition =
                                      positionData.bufferedPosition;
                                  if (bufferedPosition > duration) {
                                    bufferedPosition = duration;
                                  }
                                  if (!isPlayClicked) {
                                    return Column(
                                      children: [],
                                    );
                                  }
                                  return SeekBar(
                                    duration: duration,
                                    position: position,
                                    bufferedPosition: bufferedPosition,
                                    onChangeEnd: (newPosition) {
                                      _player.seek(
                                          newPosition ?? const Duration());
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<PlayerState>(
                  stream: _player.playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;

                    if (playerState == null) {
                      return const SizedBox.shrink();
                    }

                    final processingState = playerState.processingState;

                    final playing = playerState.playing;
                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        child: const Icon(Icons.play_circle_fill),
                      );
                    } else if (playing != true) {
                      return IconButton(
                        icon: const Icon(Icons.play_circle_fill),
                        onPressed: () {
                          if (!isPlayClicked) {
                            // setState(() {
                            isPlayClicked = true;
                            // });
                          }
                          _audioLock.value = widget.audioEntity.id;
                          _player.play();
                        },
                      );
                    } else if (processingState != ProcessingState.completed) {
                      return IconButton(
                        icon: const Icon(Icons.pause_circle_filled),
                        onPressed: () {
                          _player.pause();
                        },
                      );
                    } else {
                      return IconButton(
                        icon: const Icon(Icons.replay),
                        onPressed: () => _player.seek(
                          Duration.zero,
                          index: _player.effectiveIndices!.first,
                        ),
                      );
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
