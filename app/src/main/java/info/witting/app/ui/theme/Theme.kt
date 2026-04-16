package info.witting.app.ui.theme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
private val LightColorScheme = lightColorScheme(
    primary = Color(0xFF2563eb),
    secondary = Color(0xFF1e40af),
    background = Color(0xFFf8fafc),
    surface = Color(0xFFffffff),
)
@Composable
fun WittingAppTheme(content: @Composable () -> Unit) {
    MaterialTheme(colorScheme = LightColorScheme, content = content)
}
