import SwiftUI

/// UI sample for iOS 16+. Supply localized, verified store data and real callbacks.
struct PaywallPlan: Identifiable, Equatable {
    let id: String
    let title: String
    /// Total billed amount and interval, e.g. "$39.99 / year".
    let billingLabel: String
    /// Optional equivalent or verified savings; visually secondary.
    let detail: String?
    /// Eligibility-aware action and full renewal disclosure from the billing layer.
    let actionLabel: String
    let disclosure: String
}

enum PaywallActionResult {
    /// Caller has verified the entitlement; the view itself never grants access.
    case verified
    case cancelled
    case pending
    case nothingToRestore
    case failed(String)
}

struct PaywallView: View {
    let plans: [PaywallPlan]
    let isLoading: Bool
    let loadError: String?
    let onPurchase: @MainActor (PaywallPlan) async -> PaywallActionResult
    let onRestore: @MainActor () async -> PaywallActionResult
    let onReload: () -> Void
    let onDismiss: () -> Void
    let onTerms: () -> Void
    let onPrivacy: () -> Void

    @State private var selectedID: String?
    @State private var isBusy = false
    @State private var status: String?
    @State private var operation: Task<Void, Never>?
    @Environment(\.dynamicTypeSize) private var textSize

    private let ink = Color(red: 0.12, green: 0.20, blue: 0.17)
    private let accent = Color(red: 0.19, green: 0.33, blue: 0.26)
    private let paper = Color(red: 0.97, green: 0.96, blue: 0.92)
    private var selectedPlan: PaywallPlan? {
        plans.first(where: { $0.id == selectedID }) ?? plans.first
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text("GROVE / PLUS")
                        .font(.caption.weight(.bold))
                        .tracking(2)
                    Spacer()
                    Button(action: onDismiss) {
                        Image(systemName: "xmark")
                            .frame(minWidth: 44, minHeight: 44)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Close subscription offer")
                }

                VStack(alignment: .leading, spacing: 12) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(accent)
                        .accessibilityHidden(true)
                    Text("Make room\nfor a little calm.")
                        .font(.largeTitle.weight(.semibold))
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityAddTraits(.isHeader)
                    Text("Unlock the full library of guided sessions with Grove Plus.")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }

                VStack(alignment: .leading, spacing: 14) {
                    benefit("Guided sessions for everyday moments", icon: "headphones")
                    benefit("Save your favorites for offline listening", icon: "arrow.down.circle")
                    benefit("Build a routine at your own pace", icon: "sun.max")
                }

                if isLoading {
                    ProgressView("Loading subscription options…")
                        .frame(maxWidth: .infinity, minHeight: 80)
                } else if let loadError = loadError {
                    recovery(loadError)
                } else if plans.isEmpty {
                    recovery("Subscription options are unavailable right now.")
                } else {
                    VStack(spacing: 12) {
                        ForEach(plans) { plan in
                            planButton(plan)
                        }
                    }

                    if let plan = selectedPlan {
                        VStack(spacing: 12) {
                            Button {
                                perform { await onPurchase(plan) }
                            } label: {
                                HStack(spacing: 10) {
                                    if isBusy { ProgressView().tint(.white) }
                                    Text(isBusy ? "Please wait…" : plan.actionLabel)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(18)
                                .frame(maxWidth: .infinity, minHeight: 52)
                                .foregroundStyle(.white)
                                .background(accent, in: RoundedRectangle(cornerRadius: 18))
                            }
                            .buttonStyle(.plain)
                            .disabled(isBusy)

                            Text(plan.disclosure)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }

                if let status = status {
                    Text(status)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background(.white.opacity(0.8), in: RoundedRectangle(cornerRadius: 12))
                        .accessibilityLabel("Purchase status: \(status)")
                }

                VStack(spacing: 4) {
                    Button("Restore purchases") {
                        perform { await onRestore() }
                    }
                    .frame(minHeight: 44)
                    .disabled(isBusy)
                    HStack(spacing: 24) {
                        Button("Terms", action: onTerms).frame(minHeight: 44)
                        Button("Privacy", action: onPrivacy).frame(minHeight: 44)
                    }
                }
                .font(.subheadline)
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity)
            }
            .padding(24)
            .frame(maxWidth: 520)
            .frame(maxWidth: .infinity)
        }
        .foregroundStyle(ink)
        .tint(accent)
        .background(paper.ignoresSafeArea())
        .preferredColorScheme(.light)
        .onDisappear {
            // The billing service must own transaction observation beyond this UI.
            operation?.cancel()
            operation = nil
            isBusy = false
        }
    }

    private func benefit(_ text: String, icon: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon).frame(width: 24).accessibilityHidden(true)
            Text(text).fixedSize(horizontal: false, vertical: true)
        }
        .font(.body)
        .accessibilityElement(children: .combine)
    }

    private func recovery(_ message: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(message).fixedSize(horizontal: false, vertical: true)
            Button("Try again", action: onReload).frame(minHeight: 44).disabled(isBusy)
        }
    }

    private func planButton(_ plan: PaywallPlan) -> some View {
        let selected = selectedPlan?.id == plan.id
        return Button {
            selectedID = plan.id
            status = nil
        } label: {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .accessibilityHidden(true)
                VStack(alignment: .leading, spacing: 8) {
                    // Vertical at accessibility sizes to prevent price truncation.
                    if textSize.isAccessibilitySize {
                        Text(plan.title).font(.headline)
                        Text(plan.billingLabel).font(.title3.weight(.semibold))
                    } else {
                        ViewThatFits(in: .horizontal) {
                            HStack {
                                Text(plan.title).font(.headline)
                                Spacer(minLength: 12)
                                Text(plan.billingLabel).font(.title3.weight(.semibold))
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                Text(plan.title).font(.headline)
                                Text(plan.billingLabel).font(.title3.weight(.semibold))
                            }
                        }
                    }
                    if let detail = plan.detail {
                        Text(detail).font(.subheadline)
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(18)
            .frame(maxWidth: .infinity, minHeight: 64)
            .background(selected ? Color.white : Color.clear, in: RoundedRectangle(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).stroke(selected ? accent : ink.opacity(0.35), lineWidth: selected ? 2 : 1))
            .contentShape(RoundedRectangle(cornerRadius: 18))
        }
        .buttonStyle(.plain)
        .disabled(isBusy)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(selected ? .isSelected : [])
    }

    @MainActor
    private func perform(_ action: @escaping @MainActor () async -> PaywallActionResult) {
        guard !isBusy else { return }
        isBusy = true
        status = nil
        operation = Task { @MainActor in
            let result = await action()
            guard !Task.isCancelled else { return }
            isBusy = false
            switch result {
            case .verified: status = "Your subscription is active."
            case .cancelled: status = nil
            case .pending: status = "Your purchase is pending. Access will update after confirmation."
            case .nothingToRestore: status = "No active subscription was found for this store account."
            case .failed(let message): status = message
            }
        }
    }
}

/// Fictional offers for previews only. No real billing, network calls, or credentials.
struct GrovePaywallDemo: View {
    @State private var notice: String?
    private let samplePlans = [
        PaywallPlan(id: "demo.annual", title: "Yearly", billingLabel: "$39.99 / year",
                    detail: "About $3.33 / month, billed yearly",
                    actionLabel: "Subscribe yearly",
                    disclosure: "$39.99 charged today, then every year. Auto-renews until canceled. Manage or cancel in your App Store subscription settings."),
        PaywallPlan(id: "demo.monthly", title: "Monthly", billingLabel: "$5.99 / month",
                    detail: "Billed monthly",
                    actionLabel: "Subscribe monthly",
                    disclosure: "$5.99 charged today, then every month. Auto-renews until canceled. Manage or cancel in your App Store subscription settings.")
    ]

    var body: some View {
        PaywallView(plans: samplePlans, isLoading: false, loadError: nil,
                    onPurchase: { _ in .failed("Demo only — no payment was made. Connect your verified billing service to enable purchases.") },
                    onRestore: { .nothingToRestore },
                    onReload: {},
                    onDismiss: { notice = "Demo only — return to your app's free experience here." },
                    onTerms: { notice = "Demo only — supply your published Terms of Use URL." },
                    onPrivacy: { notice = "Demo only — supply your published Privacy Policy URL." })
        .alert("Grove demo", isPresented: Binding(get: { notice != nil }, set: { if !$0 { notice = nil } })) {
            Button("OK") { notice = nil }
        } message: {
            Text(notice ?? "")
        }
    }
}

#if DEBUG
struct GrovePaywallPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            GrovePaywallDemo().previewDisplayName("Standard")
            GrovePaywallDemo().environment(\.dynamicTypeSize, .accessibility3)
                .previewDisplayName("Larger text")
        }
    }
}
#endif
