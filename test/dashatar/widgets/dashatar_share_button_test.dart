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
}
