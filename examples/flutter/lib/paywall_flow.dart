import 'package:flutter/material.dart';

/// Display strings must come from the same verified offer sent to checkout.
/// [id] identifies the full offer, including Android base plan/offer where needed.
@immutable
class PaywallOffer {
  const PaywallOffer({
    required this.id,
    required this.title,
    required this.price,
    required this.detail,
    required this.cta,
    required this.disclosure,
  });
  final String id, title, price, detail, cta, disclosure;
}

/// Grove-specific sample UI. Localize/adapt brand copy for the host product.
/// The host owns store streams and verified entitlement, independently of routes.
class PaywallFlow extends StatefulWidget {
  const PaywallFlow({
    super.key,
    required this.offers,
    required this.onPurchase,
    required this.onRestore,
    required this.onDismiss,
    required this.onTerms,
    required this.onPrivacy,
    required this.onRetry,
    this.loading = false,
    this.busy = false,
    this.error,
    this.status,
  });
  final List<PaywallOffer> offers;
  final Future<void> Function(PaywallOffer offer) onPurchase;
  final Future<void> Function() onRestore;
  final VoidCallback onDismiss, onTerms, onPrivacy, onRetry;
  final bool loading, busy;
  final String? error, status;

  @override
  State<PaywallFlow> createState() => _PaywallFlowState();
}

class _PaywallFlowState extends State<PaywallFlow> {
  int _step = 0;
  String? _selectedId;
  bool _acting = false;
  String? _actionError;
  final _headingFocus = FocusNode();

  bool get _busy => _acting || widget.busy;
  PaywallOffer? get _offer {
    for (final offer in widget.offers) {
      if (offer.id == _selectedId) return offer;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    // Never fall back to a fabricated price or offer while products load.
    if (widget.offers.isNotEmpty) _selectedId = widget.offers.first.id;
  }

  @override
  void dispose() {
    _headingFocus.dispose();
    super.dispose();
  }

  void _go(int step) {
    setState(() => _step = step);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _headingFocus.requestFocus();
    });
  }

  void _back() {
    if (_step == 1) {
      _go(0);
    } else {
      widget.onDismiss();
    }
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() {
      _acting = true;
      _actionError = null;
    });
    try {
      await action();
    } catch (_) {
      if (mounted) {
        setState(
          () => _actionError =
              'Could not finish. Check your connection and try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _acting = false);
    }
    // Completion of a callback is NOT proof of purchase or entitlement.
  }

  @override
  Widget build(BuildContext context) {
    final offer = _offer;
    final ready = !widget.loading && widget.error == null;
    final theme = Theme.of(context);
    return PopScope<void>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _back();
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff8f6ed),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: SingleChildScrollView(
                key: ValueKey(_step),
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        if (_step == 1)
                          IconButton(
                            tooltip: 'Back to benefits',
                            onPressed: _back,
                            icon: const Icon(Icons.arrow_back),
                          ),
                        const Expanded(child: Text('GROVE / PLUS')),
                        Text('${_step + 1} of 2'),
                        IconButton(
                          tooltip: 'Close paywall',
                          onPressed: widget.onDismiss,
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Focus(
                      focusNode: _headingFocus,
                      child: Semantics(
                        header: true,
                        namesRoute: true,
                        child: Text(
                          _step == 0
                              ? 'Make room for a little calm.'
                              : 'Choose your Plus plan.',
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xff233d32),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _step == 0
                          ? 'Keep your five free starter sessions, or unlock the '
                                'full library and offline listening with Plus.'
                          : 'Full library and offline listening, on your terms.',
                    ),
                    const SizedBox(height: 28),
                    if (_step == 0) ...[
                      const _Comparison(),
                      const SizedBox(height: 28),
                      FilledButton(
                        onPressed: () => _go(1),
                        child: const Text('See plans'),
                      ),
                      TextButton(
                        onPressed: widget.onDismiss,
                        child: const Text('Continue with free sessions'),
                      ),
                      const Text(
                        'This step does not start a purchase.',
                        textAlign: TextAlign.center,
                      ),
                    ] else ...[
                      if (widget.loading)
                        const Center(
                          child: CircularProgressIndicator(
                            semanticsLabel: 'Loading plans',
                          ),
                        ),
                      if (widget.error != null) _Feedback(widget.error!),
                      if (ready && widget.offers.isEmpty)
                        const _Feedback(
                          'Plans are unavailable. Please try again.',
                        ),
                      if (!widget.loading &&
                          (widget.error != null || widget.offers.isEmpty))
                        OutlinedButton(
                          onPressed: _busy ? null : widget.onRetry,
                          child: const Text('Retry loading plans'),
                        ),
                      if (ready)
                        for (final item in widget.offers)
                          _OfferCard(
                            offer: item,
                            selected: item.id == _selectedId,
                            onTap: _busy
                                ? null
                                : () {
                                    setState(() {
                                      _selectedId = item.id;
                                      _actionError = null;
                                    });
                                  },
                          ),
                      const SizedBox(height: 12),
                      FilledButton(
                        key: const Key('purchase'),
                        onPressed: !ready || _busy || offer == null
                            ? null
                            : () => _run(() => widget.onPurchase(offer)),
                        child: Text(
                          _busy
                              ? 'Please wait…'
                              : (ready ? offer?.cta : null) ?? 'Select a plan',
                        ),
                      ),
                      if (ready && offer != null) ...[
                        const SizedBox(height: 12),
                        Text(offer.disclosure, textAlign: TextAlign.center),
                      ],
                      if (_actionError != null) _Feedback(_actionError!),
                      if (widget.status != null) _Feedback(widget.status!),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          TextButton(
                            onPressed: _busy
                                ? null
                                : () => _run(widget.onRestore),
                            child: const Text('Restore purchases'),
                          ),
                          TextButton(
                            onPressed: widget.onTerms,
                            child: const Text('Terms'),
                          ),
                          TextButton(
                            onPressed: widget.onPrivacy,
                            child: const Text('Privacy'),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Feedback extends StatelessWidget {
  const _Feedback(this.message);
  final String message;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Semantics(liveRegion: true, child: Text(message)),
  );
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.offer, required this.selected, this.onTap});
  final PaywallOffer offer;
  final bool selected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Semantics(
      label: '${offer.title}, ${offer.price}, ${offer.detail}',
      checked: selected,
      inMutuallyExclusiveGroup: true,
      enabled: onTap != null,
      onTap: onTap,
      excludeSemantics: true,
      child: Material(
        color: selected ? Colors.white : const Color(0xffeeeee3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: selected ? const Color(0xff315646) : const Color(0xffa1ab9b),
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      selected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        offer.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  offer.price,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (offer.detail.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(offer.detail),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _Comparison extends StatelessWidget {
  const _Comparison();
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final stacked =
          constraints.maxWidth < 330 ||
          MediaQuery.textScalerOf(context).scale(16) > 20;
      const rows = [
        ['Guided sessions', '5 starter sessions', 'Full library'],
        ['Offline listening', 'Not included', 'Included'],
      ];
      return Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: stacked
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final row in rows)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '${row[0]}\nFree: ${row[1]}\nPlus: ${row[2]}',
                        ),
                      ),
                  ],
                )
              : Table(
                  columnWidths: const {0: FlexColumnWidth(1.4)},
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text('Feature'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text('Free'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text('Plus'),
                        ),
                      ],
                    ),
                    for (final row in rows)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(row[0]),
                          ),
                          Semantics(
                            label: '${row[0]}, Free: ${row[1]}',
                            excludeSemantics: true,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(row[1]),
                            ),
                          ),
                          Semantics(
                            label: '${row[0]}, Plus: ${row[2]}',
                            excludeSemantics: true,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(row[2]),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
        ),
      );
    },
  );
}
