package dev.mobilepaywall.demo

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.selection.selectableGroup
import androidx.compose.foundation.verticalScroll
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.*
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp

/** Use a stable offer identity (product + base plan + offer), not a display title. */
data class PaywallPlan(
    val id: String,
    val title: String,
    val billingLabel: String,
    val detail: String?,
    val actionLabel: String,
    val disclosure: String,
)

/** Billing and entitlement work belongs to the host ViewModel/service. */
data class PaywallUiState(
    val plans: List<PaywallPlan> = emptyList(),
    val selectedId: String? = null,
    val loading: Boolean = false,
    val loadError: String? = null,
    val busy: Boolean = false,
    val status: String? = null,
) {
    val selectedPlan: PaywallPlan?
        get() = plans.firstOrNull { it.id == selectedId } ?: plans.firstOrNull()
}

@Composable
fun PaywallScreen(
    state: PaywallUiState,
    onSelect: (String) -> Unit,
    onPurchase: (PaywallPlan) -> Unit,
    onRestore: () -> Unit,
    onReload: () -> Unit,
    onDismiss: () -> Unit,
    onTerms: () -> Unit,
    onPrivacy: () -> Unit,
    modifier: Modifier = Modifier,
) {
    Surface(modifier = modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
        Box(Modifier.fillMaxSize().safeDrawingPadding(), contentAlignment = Alignment.TopCenter) {
            Column(
                Modifier.widthIn(max = 520.dp).fillMaxWidth()
                    .verticalScroll(rememberScrollState()).padding(24.dp),
                verticalArrangement = Arrangement.spacedBy(24.dp),
            ) {
                Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                    Text(stringResource(R.string.brand), style = MaterialTheme.typography.labelLarge,
                        modifier = Modifier.weight(1f))
                    val closeLabel = stringResource(R.string.close)
                    TextButton(onClick = onDismiss, modifier = Modifier.sizeIn(minWidth = 48.dp, minHeight = 48.dp)
                        .clearAndSetSemantics {
                            contentDescription = closeLabel
                            role = Role.Button
                            onClick { onDismiss(); true }
                        }) { Text("×", style = MaterialTheme.typography.headlineSmall) }
                }
                Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                    Text(stringResource(R.string.headline), style = MaterialTheme.typography.headlineLarge,
                        fontWeight = FontWeight.SemiBold, modifier = Modifier.semantics { heading() })
                    Text(stringResource(R.string.intro), style = MaterialTheme.typography.bodyLarge)
                }
                Column(verticalArrangement = Arrangement.spacedBy(14.dp)) {
                    Benefit(stringResource(R.string.benefit_sessions))
                    Benefit(stringResource(R.string.benefit_offline))
                    Benefit(stringResource(R.string.benefit_routine))
                }
                when {
                    state.loading -> Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                        CircularProgressIndicator()
                        Text(stringResource(R.string.loading))
                    }
                    state.loadError != null || state.plans.isEmpty() -> Column {
                        Text(state.loadError ?: stringResource(R.string.unavailable))
                        TextButton(onClick = onReload, enabled = !state.busy) { Text(stringResource(R.string.retry)) }
                    }
                    else -> {
                        Column(Modifier.selectableGroup(), verticalArrangement = Arrangement.spacedBy(12.dp)) {
                            state.plans.forEach { plan ->
                                PlanCard(plan, state.selectedPlan?.id == plan.id, !state.busy) { onSelect(plan.id) }
                            }
                        }
                        state.selectedPlan?.let { selected ->
                            Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                                Button(
                                    onClick = { onPurchase(selected) }, enabled = !state.busy,
                                    modifier = Modifier.fillMaxWidth().heightIn(min = 56.dp),
                                    shape = RoundedCornerShape(18.dp), contentPadding = PaddingValues(18.dp),
                                ) {
                                    Text(stringResource(R.string.waiting).takeIf { state.busy } ?: selected.actionLabel,
                                        textAlign = TextAlign.Center, style = MaterialTheme.typography.titleMedium)
                                }
                                Text(selected.disclosure, modifier = Modifier.fillMaxWidth(),
                                    textAlign = TextAlign.Center, style = MaterialTheme.typography.bodyMedium)
                            }
                        }
                    }
                }
                state.status?.let { message ->
                    Surface(shape = RoundedCornerShape(12.dp), color = MaterialTheme.colorScheme.surfaceVariant) {
                        Text(message, Modifier.fillMaxWidth().padding(16.dp).semantics { liveRegion = LiveRegionMode.Polite })
                    }
                }
                Column(Modifier.fillMaxWidth(), horizontalAlignment = Alignment.CenterHorizontally) {
                    TextButton(onClick = onRestore, enabled = !state.busy) { Text(stringResource(R.string.restore)) }
                    // Separate rows avoid clipped legal controls with large text/translations.
                    TextButton(onClick = onTerms) { Text(stringResource(R.string.terms)) }
                    TextButton(onClick = onPrivacy) { Text(stringResource(R.string.privacy)) }
                }
            }
        }
    }
}

@Composable
private fun Benefit(text: String) {
    Row(horizontalArrangement = Arrangement.spacedBy(12.dp), modifier = Modifier.semantics(mergeDescendants = true) {}) {
        Text("✓", modifier = Modifier.clearAndSetSemantics {})
        Text(text, style = MaterialTheme.typography.bodyLarge)
    }
}

@Composable
private fun PlanCard(plan: PaywallPlan, selected: Boolean, enabled: Boolean, onSelect: () -> Unit) {
    val colors = MaterialTheme.colorScheme
    Surface(
        shape = RoundedCornerShape(18.dp), color = if (selected) colors.surface else colors.background,
        border = BorderStroke(if (selected) 2.dp else 1.dp, if (selected) colors.primary else colors.outline),
        modifier = Modifier.fillMaxWidth().selectable(selected, enabled = enabled, role = Role.RadioButton, onClick = onSelect),
    ) {
        Row(Modifier.padding(18.dp), horizontalArrangement = Arrangement.spacedBy(12.dp)) {
            RadioButton(selected = selected, onClick = null, enabled = enabled, modifier = Modifier.clearAndSetSemantics {})
            Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text(plan.title, style = MaterialTheme.typography.titleMedium)
                // Keep the real billed total on its own line, including at larger font scales.
                Text(plan.billingLabel, style = MaterialTheme.typography.titleLarge, fontWeight = FontWeight.SemiBold)
                plan.detail?.let { Text(it, style = MaterialTheme.typography.bodyMedium) }
            }
        }
    }
}
