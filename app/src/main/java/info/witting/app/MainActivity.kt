package info.witting.app
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import info.witting.app.ui.theme.WittingAppTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { WittingAppTheme { MainScreen() } }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MainScreen() {
    var selectedTab by remember { mutableStateOf(0) }
    val context = LocalContext.current
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Witting.info", color = Color.White, fontWeight = FontWeight.Bold) },
                colors = TopAppBarDefaults.topAppBarColors(containerColor = Color(0xFF2563eb))
            )
        },
        bottomBar = {
            NavigationBar(containerColor = Color.White) {
                NavigationBarItem(
                    icon = { Icon(Icons.Default.Home, contentDescription = "Dashboard") },
                    label = { Text("Dashboard") },
                    selected = selectedTab == 0,
                    onClick = { selectedTab = 0 },
                    colors = NavigationBarItemDefaults.colors(selectedIconColor = Color(0xFF2563eb), selectedTextColor = Color(0xFF2563eb))
                )
                NavigationBarItem(
                    icon = { Icon(Icons.Default.DateRange, contentDescription = "Termine") },
                    label = { Text("Termine") },
                    selected = selectedTab == 1,
                    onClick = { selectedTab = 1 },
                    colors = NavigationBarItemDefaults.colors(selectedIconColor = Color(0xFF2563eb), selectedTextColor = Color(0xFF2563eb))
                )
                NavigationBarItem(
                    icon = { Icon(Icons.Default.List, contentDescription = "Rechnungen") },
                    label = { Text("Rechnungen") },
                    selected = selectedTab == 2,
                    onClick = { selectedTab = 2 },
                    colors = NavigationBarItemDefaults.colors(selectedIconColor = Color(0xFF2563eb), selectedTextColor = Color(0xFF2563eb))
                )
            }
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = {
                    val intent = Intent(Intent.ACTION_SENDTO).apply {
                        data = Uri.parse("mailto:kontakt@witting.info")
                        putExtra(Intent.EXTRA_SUBJECT, "NOTFALL: IT Support benötigt")
                        putExtra(Intent.EXTRA_TEXT, "Bitte um schnellen Rückruf unter:\n\nMein Notfall:")
                    }
                    context.startActivity(intent)
                },
                containerColor = Color(0xFFef4444),
                contentColor = Color.White
            ) {
                Icon(Icons.Default.Warning, contentDescription = "Notfall")
            }
        }
    ) { paddingValues ->
        Box(modifier = Modifier.padding(paddingValues).fillMaxSize().background(Color(0xFFf8fafc))) {
            when (selectedTab) {
                0 -> DashboardScreen()
                1 -> AppointmentsScreen()
                2 -> InvoicesScreen()
            }
        }
    }
}

@Composable
fun DashboardScreen() {
    Column(modifier = Modifier.padding(16.dp)) {
        Text("Willkommen bei Witting IT", fontSize = 24.sp, fontWeight = FontWeight.Bold, color = Color(0xFF1e293b))
        Spacer(modifier = Modifier.height(16.dp))
        Card(modifier = Modifier.fillMaxWidth(), colors = CardDefaults.cardColors(containerColor = Color.White)) {
            Column(modifier = Modifier.padding(16.dp)) {
                Text("Nächster Termin", fontWeight = FontWeight.Bold, color = Color(0xFF2563eb))
                Text("Server-Wartung", fontSize = 18.sp, modifier = Modifier.padding(top = 8.dp))
                Text("In Kürze", color = Color.Gray)
            }
        }
        Spacer(modifier = Modifier.height(24.dp))
        Text("Notfallnummer: +49 123 456789", color = Color(0xFFef4444), fontWeight = FontWeight.Bold, fontSize = 18.sp)
    }
}

@Composable
fun AppointmentsScreen() {
    Column(modifier = Modifier.padding(16.dp)) {
        Text("Termine", fontSize = 24.sp, fontWeight = FontWeight.Bold, color = Color(0xFF1e293b))
        Spacer(modifier = Modifier.height(16.dp))
        Button(
            onClick = { /* TODO */ },
            colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF2563eb)),
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Neuen Termin anfragen")
        }
        Spacer(modifier = Modifier.height(16.dp))
        LazyColumn {
            items(2) { index ->
                Card(modifier = Modifier.fillMaxWidth().padding(bottom = 8.dp), colors = CardDefaults.cardColors(containerColor = Color.White)) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Text(if (index == 0) "Kommend" else "Vergangen", color = if (index == 0) Color(0xFF2563eb) else Color.Gray)
                        Text("IT-Support Session", fontSize = 16.sp, fontWeight = FontWeight.Bold)
                    }
                }
            }
        }
    }
}

@Composable
fun InvoicesScreen() {
    Column(modifier = Modifier.padding(16.dp)) {
        Text("Rechnungen", fontSize = 24.sp, fontWeight = FontWeight.Bold, color = Color(0xFF1e293b))
        Spacer(modifier = Modifier.height(16.dp))
        LazyColumn {
            items(2) { index ->
                Card(modifier = Modifier.fillMaxWidth().padding(bottom = 8.dp), colors = CardDefaults.cardColors(containerColor = Color.White)) {
                    Row(modifier = Modifier.padding(16.dp).fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                        Column {
                            Text("RE-2026-${100 + index}", fontWeight = FontWeight.Bold)
                            Text("Bezahlt", color = Color(0xFF10b981))
                        }
                        Text("120,00 €", fontWeight = FontWeight.Bold)
                    }
                }
            }
        }
    }
}
