package dev.mobwall.demo

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.BackHandler
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent { GrovePaywallDemo() }
    }
}

/** Fictional USD offers. Never substitute these for localized Google Play product data. */
@Composable
fun GrovePaywallDemo() {
    var showing by rememberSaveable { mutableStateOf(true) }
    var selectedId by rememberSaveable { mutableStateOf<String?>(null) }
    var status by rememberSaveable { mutableStateOf<String?>(null) }
    val purchaseMessage = stringResource(R.string.demo_purchase)
    val restoreMessage = stringResource(R.string.demo_restore)
    val legalMessage = stringResource(R.string.demo_legal)
    val plans = listOf(
        PaywallPlan("demo:annual:no-offer", stringResource(R.string.yearly), stringResource(R.string.yearly_price),
            stringResource(R.string.yearly_detail), stringResource(R.string.yearly_cta), stringResource(R.string.yearly_disclosure)),
        PaywallPlan("demo:monthly:no-offer", stringResource(R.string.monthly), stringResource(R.string.monthly_price),
            stringResource(R.string.monthly_detail), stringResource(R.string.monthly_cta), stringResource(R.string.monthly_disclosure)),
    )
    MaterialTheme(colorScheme = lightColorScheme(
        primary = Color(0xFF305443), onPrimary = Color.White,
        background = Color(0xFFF7F5EB), onBackground = Color(0xFF1F332B),
        surface = Color.White, onSurface = Color(0xFF1F332B),
        surfaceVariant = Color(0xFFE4E8DB), onSurfaceVariant = Color(0xFF1F332B),
    )) {
        BackHandler(enabled = showing) { showing = false }
        if (showing) {
            PaywallScreen(
                state = PaywallUiState(plans = plans, selectedId = selectedId, status = status),
                onSelect = { selectedId = it; status = null },
                onPurchase = { status = purchaseMessage },
                onRestore = { status = restoreMessage },
                onReload = { status = null },
                onDismiss = { showing = false },
                onTerms = { status = legalMessage }, onPrivacy = { status = legalMessage },
            )
        } else {
            Surface(Modifier.fillMaxSize()) {
                Column(Modifier.safeDrawingPadding().padding(24.dp), verticalArrangement = Arrangement.Center) {
                    Text(stringResource(R.string.free_screen))
                    Button(onClick = { showing = true; status = null }) { Text(stringResource(R.string.show_offer)) }
                }
            }
        }
    }
}

@Preview(name = "Standard", widthDp = 390, heightDp = 844, showBackground = true)
@Preview(name = "Compact, larger text", widthDp = 320, heightDp = 640, fontScale = 1.5f, showBackground = true)
@Composable
private fun GrovePreview() { GrovePaywallDemo() }
