import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';

import 'helpers.dart';

void main() {
  late UrlLauncherPlatform urlLauncher;

  setUp(() {
    urlLauncher = MockUrlLauncher();
    UrlLauncherPlatform.instance = urlLauncher;
  });

  group('openLink', () {
    test('launches the link', () async {
      when(() => urlLauncher.canLaunch('url')).thenAnswer((_) async => true);
      when(
        () => urlLauncher.launch(
          'url',
          useSafariVC: false,
          useWebView: false,
          enableJavaScript: false,
          enableDomStorage: false,
          universalLinksOnly: false,
          headers: const {},
        ),
      ).thenAnswer((_) async => true);
      await openLink('url');
      verify(
        () => urlLauncher.launch(
          'url',
          useSafariVC: false,
          useWebView: false,
          enableJavaScript: false,
          enableDomStorage: false,
          universalLinksOnly: false,
          headers: const {},
        ),
      ).called(1);
    });

    test('executes the onError callback when it cannot launch', () async {
      var wasCalled = false;
      when(() => urlLauncher.canLaunch('url')).thenAnswer((_) async => false);
      when(
        () => urlLauncher.launch(
          'url',
          useSafariVC: false,
          useWebView: false,
          enableJavaScript: false,
          enableDomStorage: false,
          universalLinksOnly: false,
          headers: const {},
        ),
      ).thenAnswer((_) async => true);
      await openLink(
        'url',
        onError: () {
          wasCalled = true;
        },
      );
      await expectLater(wasCalled, isTrue);
    });
  });
}
