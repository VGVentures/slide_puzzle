import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_analysis/very_good_analysis.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('getAudioPlayer', () {
    test('returns a new instance of AudioPlayer', () {
      expect(getAudioPlayer(), isA<AudioPlayer>());
    });
  });

  group('replay', () {
    test('replays the audio', () async {
      final audioPlayer = AudioPlayer();
      unawaited(audioPlayer.play());

      var playCount = 0;
      audioPlayer.playingStream.listen((playing) {
        if (playing == true) {
          playCount++;
        }
      });

      await audioPlayer.replay();
      await Future.microtask(() {});

      expect(playCount, equals(2));
    });
  });
}
