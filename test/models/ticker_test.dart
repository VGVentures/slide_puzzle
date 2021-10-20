import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

void main() {
  group('Ticker', () {
    group('tick', () {
      test('returns stream of integers', () {
        const ticker = Ticker();
        final stream = ticker.tick();
        expect(stream, isA<Stream<int>>());
      });

      test('returns stream of integers counting up from 1', () async {
        await fakeAsync((async) async {
          final events = <int>[];
          const ticker = Ticker();
          final subscription = ticker.tick().listen(events.add);
          async.elapse(const Duration(seconds: 20));
          await subscription.cancel();
          expect(
            events,
            [
              for (int i = 1; i <= 20; i++) i,
            ],
          );
        });
      });
    });
  });
}
