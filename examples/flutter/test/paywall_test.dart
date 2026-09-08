import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_paywall_demo/main.dart';
import 'package:mobile_paywall_demo/paywall_flow.dart';

Widget host({
  List<PaywallOffer> offers = demoOffers,
  Future<void> Function(PaywallOffer)? purchase,
  Future<void> Function()? restore,
  VoidCallback? dismiss,
  VoidCallback? retry,
  bool loading = false,
  bool busy = false,
  String? error,
  TextScaler scaler = TextScaler.noScaling,
}) => MaterialApp(
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: scaler),
    child: child!,
  ),
  home: PaywallFlow(
    offers: offers,
    onPurchase: purchase ?? (_) async {},
    onRestore: restore ?? () async {},
    onDismiss: dismiss ?? () {},
    onTerms: () {},
    onPrivacy: () {},
    onRetry: retry ?? () {},
    loading: loading,
    busy: busy,
    error: error,
  ),
);

Future<void> tapVisible(WidgetTester tester, Finder target) async {
  await tester.ensureVisible(target);
  await tester.pumpAndSettle();
  await tester.tap(target);
  await tester.pump();
}

void main() {
  testWidgets('value step never purchases; selection survives Back', (
    tester,
  ) async {
    final purchases = <String>[];
    await tester.pumpWidget(
      host(
        purchase: (offer) async {
          purchases.add(offer.id);
        },
      ),
    );
    await tapVisible(tester, find.text('See plans'));
    expect(purchases, isEmpty);
    await tapVisible(tester, find.text('Monthly'));
    await tapVisible(tester, find.byTooltip('Back to benefits'));
    await tapVisible(tester, find.text('See plans'));
    expect(find.text('Subscribe monthly'), findsOneWidget);
    await tapVisible(tester, find.byKey(const Key('purchase')));
    expect(purchases, ['demo.grove.monthly']);
    expect(find.text(demoOffers[1].disclosure), findsOneWidget);
  });

  testWidgets('duplicate purchase and restore blocked while pending', (
    tester,
  ) async {
    final done = Completer<void>();
    var calls = 0;
    var restores = 0;
    await tester.pumpWidget(
      host(
        purchase: (_) {
          calls++;
          return done.future;
        },
        restore: () async {
          restores++;
        },
      ),
    );
    await tapVisible(tester, find.text('See plans'));
    await tapVisible(tester, find.byKey(const Key('purchase')));
    await tapVisible(tester, find.byKey(const Key('purchase')));
    await tapVisible(tester, find.text('Restore purchases'));
    expect(calls, 1);
    expect(restores, 0);
    expect(
      tester.widget<FilledButton>(find.byKey(const Key('purchase'))).onPressed,
      isNull,
    );
    done.complete();
    await tester.pumpAndSettle();
    expect(find.text('Subscribe yearly'), findsOneWidget);
  });

  testWidgets('removed selected offer cannot be bought', (tester) async {
    await tester.pumpWidget(host());
    await tapVisible(tester, find.text('See plans'));
    await tester.pumpWidget(host(offers: [demoOffers[1]]));
    expect(
      tester.widget<FilledButton>(find.byKey(const Key('purchase'))).onPressed,
      isNull,
    );
    await tapVisible(tester, find.text('Monthly'));
    expect(
      tester.widget<FilledButton>(find.byKey(const Key('purchase'))).onPressed,
      isNotNull,
    );
  });

  testWidgets('empty, loading and error do not expose a checkout', (
    tester,
  ) async {
    var retries = 0;
    await tester.pumpWidget(host(offers: [], retry: () => retries++));
    await tapVisible(tester, find.text('See plans'));
    await tapVisible(tester, find.text('Retry loading plans'));
    expect(retries, 1);
    await tester.pumpWidget(host(loading: true));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byKey(const Key('purchase'))).onPressed,
      isNull,
    );
    await tester.pumpWidget(host(error: 'Store unavailable'));
    expect(find.text('Store unavailable'), findsOneWidget);
    expect(find.text('Yearly'), findsNothing);
    expect(
      tester.widget<FilledButton>(find.byKey(const Key('purchase'))).onPressed,
      isNull,
    );
  });

  testWidgets('failure is recoverable and disposal during purchase is safe', (
    tester,
  ) async {
    var attempts = 0;
    final done = Completer<void>();
    await tester.pumpWidget(
      host(
        purchase: (_) async {
          attempts++;
          if (attempts == 1) throw Exception('test failure');
          await done.future;
        },
      ),
    );
    await tapVisible(tester, find.text('See plans'));
    await tapVisible(tester, find.byKey(const Key('purchase')));
    expect(
      find.text('Could not finish. Check your connection and try again.'),
      findsOneWidget,
    );
    await tapVisible(tester, find.byKey(const Key('purchase')));
    await tester.pumpWidget(const SizedBox());
    done.complete();
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('system Back returns to value then dismisses', (tester) async {
    var dismissals = 0;
    await tester.pumpWidget(host(dismiss: () => dismissals++));
    await tapVisible(tester, find.text('See plans'));
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('See plans'), findsOneWidget);
    expect(dismissals, 0);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(dismissals, 1);
  });

  testWidgets('320px screen and 2x text remain scrollable without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(host(scaler: TextScaler.linear(2)));
    expect(tester.takeException(), isNull);
    await tapVisible(tester, find.text('See plans'));
    await tapVisible(tester, find.text('Monthly'));
    await tapVisible(tester, find.text('Privacy'));
    expect(tester.takeException(), isNull);
  });

  testWidgets('close returns demo to free entry and reopen resets flow', (
    tester,
  ) async {
    await tester.pumpWidget(const GroveDemo());
    await tapVisible(tester, find.byTooltip('Close paywall'));
    await tapVisible(tester, find.text('Preview Plus plans'));
    expect(find.text('See plans'), findsOneWidget);
  });
}
