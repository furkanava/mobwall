import 'package:flutter/material.dart';
import 'paywall_flow.dart';

// Fictional prices; never use these as fallback for failed store queries.
const demoOffers = [
  PaywallOffer(
    id: 'demo.grove.yearly',
    title: 'Yearly',
    price: r'$39.99 / year',
    detail: r'About $3.33 / month, billed yearly',
    cta: 'Subscribe yearly',
    disclosure:
        r'$39.99 today, then yearly. Auto-renews until canceled. '
        "Manage in your store's subscription settings.",
  ),
  PaywallOffer(
    id: 'demo.grove.monthly',
    title: 'Monthly',
    price: r'$5.99 / month',
    detail: 'Billed monthly',
    cta: 'Subscribe monthly',
    disclosure:
        r'$5.99 today, then monthly. Auto-renews until canceled. '
        "Manage in your store's subscription settings.",
  ),
];

void main() => runApp(const GroveDemo());

class GroveDemo extends StatelessWidget {
  const GroveDemo({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Grove — paywall demo',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff315646)),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        ),
      ),
    ),
    home: const _DemoHome(),
  );
}

class _DemoHome extends StatefulWidget {
  const _DemoHome();
  @override
  State<_DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<_DemoHome> {
  bool _showPaywall = true;
  String? _status;
  void _notice(String message) => setState(() => _status = message);
  @override
  Widget build(BuildContext context) => _showPaywall
      ? PaywallFlow(
          offers: demoOffers,
          status: _status,
          onPurchase: (offer) async => _notice(
            'Demo only: ${offer.title} selected. No payment was made.',
          ),
          onRestore: () async => _notice(
            'Demo only: no store is connected. Nothing was restored.',
          ),
          onTerms: () => _notice('Demo: connect your published Terms URL.'),
          onPrivacy: () => _notice('Demo: connect your published Privacy URL.'),
          onRetry: () => _notice('Demo: connect your product loader.'),
          onDismiss: () => setState(() => _showPaywall = false),
        )
      : Scaffold(
          appBar: AppBar(title: const Text('Grove demo')),
          body: Center(
            child: FilledButton(
              onPressed: () => setState(() {
                _status = null;
                _showPaywall = true;
              }),
              child: const Text('Preview Plus plans'),
            ),
          ),
        );
}
