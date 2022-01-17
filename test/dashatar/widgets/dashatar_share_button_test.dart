// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

import '../../helpers/helpers.dart';

void main() {
  late UrlLauncherPlatform urlLauncher;

  setUp(() {
    urlLauncher = MockUrlLauncher();
    UrlLauncherPlatform.instance = urlLauncher;

    when(() => urlLauncher.canLaunch(any())).thenAnswer((_) async => true);
    when(
      () => urlLauncher.launch(
        any(),
        useSafariVC: any(named: 'useSafariVC'),
        useWebView: any(named: 'useWebView'),
        enableJavaScript: any(named: 'enableJavaScript'),
        enableDomStorage: any(named: 'enableDomStorage'),
        universalLinksOnly: any(named: 'universalLinksOnly'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) async => true);
  });

  group('DashatarTwitterButton', () {
    testWidgets('renders TextButton', (tester) async {
      await tester.pumpApp(DashatarTwitterButton());
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('opens a link when tapped', (tester) async {
      await tester.pumpApp(DashatarTwitterButton());
      await tester.tap(find.byType(DashatarTwitterButton));
      verify(
        () => urlLauncher.launch(
          any(),
          useSafariVC: any(named: 'useSafariVC'),
          useWebView: any(named: 'useWebView'),
          enableJavaScript: any(named: 'enableJavaScript'),
          enableDomStorage: any(named: 'enableDomStorage'),
          universalLinksOnly: any(named: 'universalLinksOnly'),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });
  });

  group('DashatarFacebookButton', () {
    testWidgets('renders TextButton', (tester) async {
      await tester.pumpApp(DashatarFacebookButton());
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('opens a link when tapped', (tester) async {
      await tester.pumpApp(DashatarFacebookButton());
      await tester.tap(find.byType(DashatarFacebookButton));
      verify(
        () => urlLauncher.launch(
          any(),
          useSafariVC: any(named: 'useSafariVC'),
          useWebView: any(named: 'useWebView'),
          enableJavaScript: any(named: 'enableJavaScript'),
          enableDomStorage: any(named: 'enableDomStorage'),
          universalLinksOnly: any(named: 'universalLinksOnly'),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });
  });

  group('DashatarShareButton', () {
    testWidgets('plays the click sound when tapped', (tester) async {
      final audioPlayer = MockAudioPlayer();
      when(() => audioPlayer.setAsset(any())).thenAnswer((_) async => null);
      when(() => audioPlayer.seek(any())).thenAnswer((_) async {});
      when(audioPlayer.play).thenAnswer((_) async {});
      when(audioPlayer.stop).thenAnswer((_) async {});
      when(audioPlayer.dispose).thenAnswer((_) async {});

      await tester.pumpApp(
        DashatarShareButton(
          title: 'title',
          icon: SizedBox(),
          onPressed: () {},
          color: Colors.black,
          audioPlayer: () => audioPlayer,
        ),
      );

      await tester.tap(find.byType(DashatarShareButton));

      verify(() => audioPlayer.setAsset('assets/audio/click.mp3')).called(1);
      verify(audioPlayer.play).called(1);
    });
  });
}
