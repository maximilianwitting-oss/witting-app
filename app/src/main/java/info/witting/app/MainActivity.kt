package info.witting.app

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.List
import androidx.compose.material.icons.filled.Warning
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
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

// Glassmorphism modifier helper
fun Modifier.glassmorphism(radius: Int = 24) = this
    .clip(RoundedCornerShape(radius.dp))
    .background(Color(0x33FFFFFF)) // 20% white
    .border(1.dp, Color(0x4DFFFFFF), RoundedCornerShape(radius.dp)) // 30% white border

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MainScreen() {
    var selectedTab by remember { mutableStateOf(0) }
    val context = LocalContext.current

    Box(modifier = Modifier.fillMaxSize()) {
        // Full screen Liquid Glass Background
        Image(
            painter = painterResource(id = R.drawable.bg_liquid),
            contentDescription = "Background",
            contentScale = ContentScale.Crop,
            modifier = Modifier.fillMaxSize()
        )
        
        // Gradient overlay to ensure text readability
        Box(modifier = Modifier
            .fillMaxSize()
            .background(Brush.verticalGradient(listOf(Color(0x80000000), Color(0x20000000), Color(0x90000000))))
        )

        // Main Content Area
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(bottom = 100.dp) // Leave space for floating nav
        ) {
            // Header
            Text(
                text = "Witting.info",
                color = Color.White,
                fontWeight = FontWeight.ExtraBold,
                fontSize = 28.sp,
                modifier = Modifier.padding(start = 24.dp, top = 48.dp, bottom = 16.dp)
            )

            when (selectedTab) {
                0 -> DashboardScreen()
                1 -> AppointmentsScreen()
                2 -> InvoicesScreen()
            }
        }

        // Floating Emergency Button
        FloatingActionButton(
            onClick = {
                val intent = Intent(Intent.ACTION_SENDTO).apply {
                    data = Uri.parse("mailto:kontakt@witting.info")
                    putExtra(Intent.EXTRA_SUBJECT, "NOTFALL: IT Support benötigt")
                    putExtra(Intent.EXTRA_TEXT, "Bitte um schnellen Rückruf!\n\nMein Notfall:")
                }
                context.startActivity(intent)
            },
            containerColor = Color(0xFFff3b30), // iOS Red
            contentColor = Color.White,
            shape = CircleShape,
            modifier = Modifier
                .align(Alignment.BottomEnd)
                .padding(end = 24.dp, bottom = 120.dp)
        ) {
            Icon(Icons.Default.Warning, contentDescription = "Notfall")
        }

        // Floating Glassmorphism Bottom Navigation
        Box(
            modifier = Modifier
                .align(Alignment.BottomCenter)
                .padding(24.dp)
                .fillMaxWidth()
                .height(72.dp)
                .glassmorphism(36)
        ) {
            Row(
                modifier = Modifier.fillMaxSize(),
                horizontalArrangement = Arrangement.SpaceEvenly,
                verticalAlignment = Alignment.CenterVertically
            ) {
                NavItem(icon = Icons.Default.Home, label = "Home", isSelected = selectedTab == 0) { selectedTab = 0 }
                NavItem(icon = Icons.Default.DateRange, label = "Termine", isSelected = selectedTab == 1) { selectedTab = 1 }
                NavItem(icon = Icons.Default.List, label = "Rechnungen", isSelected = selectedTab == 2) { selectedTab = 2 }
            }
        }
    }
}

@Composable
fun NavItem(icon: androidx.compose.ui.graphics.vector.ImageVector, label: String, isSelected: Boolean, onClick: () -> Unit) {
    val color = if (isSelected) Color.White else Color(0x80FFFFFF)
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier.clickable(onClick = onClick).padding(8.dp)
    ) {
        Icon(icon, contentDescription = label, tint = color, modifier = Modifier.size(28.dp))
        if (isSelected) {
            Box(modifier = Modifier.padding(top = 4.dp).size(4.dp).background(Color.White, CircleShape))
        }
    }
}

@Composable
fun DashboardScreen() {
    LazyColumn(
        modifier = Modifier.fillMaxSize().padding(horizontal = 24.dp),
        contentPadding = PaddingValues(bottom = 24.dp)
    ) {
        item {
            Text("Willkommen zurück, Max", fontSize = 18.sp, color = Color(0xCCFFFFFF))
            Spacer(modifier = Modifier.height(24.dp))
            
            // Hero Glass Card with Image
            Box(modifier = Modifier.fillMaxWidth().glassmorphism(28).padding(1.dp)) {
                Column {
                    Image(
                        painter = painterResource(id = R.drawable.tech_glass),
                        contentDescription = "Tech Glass",
                        contentScale = ContentScale.Crop,
                        modifier = Modifier.fillMaxWidth().height(140.dp).clip(RoundedCornerShape(topStart = 28.dp, topEnd = 28.dp))
                    )
                    Column(modifier = Modifier.padding(20.dp)) {
                        Text("Systemstatus: Exzellent", color = Color.White, fontWeight = FontWeight.Bold, fontSize = 20.sp)
                        Text("Alle Server laufen reibungslos.", color = Color(0xAAFFFFFF), fontSize = 14.sp)
                    }
                }
            }
            
            Spacer(modifier = Modifier.height(20.dp))
            Text("Übersicht", fontSize = 22.sp, fontWeight = FontWeight.Bold, color = Color.White)
            Spacer(modifier = Modifier.height(16.dp))

            // Info Card
            Box(modifier = Modifier.fillMaxWidth().glassmorphism(24).padding(20.dp)) {
                Column {
                    Text("Nächster Termin", fontWeight = FontWeight.Bold, color = Color(0xFF60a5fa))
                    Text("Server-Wartung", fontSize = 18.sp, color = Color.White, modifier = Modifier.padding(top = 4.dp))
                    Text("Morgen, 10:00 Uhr", color = Color(0xAAFFFFFF))
                }
            }
            
            Spacer(modifier = Modifier.height(16.dp))
            
            // Emergency Info Card
            Box(modifier = Modifier.fillMaxWidth().glassmorphism(24).padding(20.dp)) {
                Column {
                    Text("Support Hotline", fontWeight = FontWeight.Bold, color = Color.White)
                    Text("+49 123 456 789", fontSize = 18.sp, color = Color(0xFFff3b30), modifier = Modifier.padding(top = 4.dp))
                }
            }
        }
    }
}

@Composable
fun AppointmentsScreen() {
    LazyColumn(modifier = Modifier.fillMaxSize().padding(horizontal = 24.dp)) {
        item {
            Text("Deine Termine", fontSize = 22.sp, fontWeight = FontWeight.Bold, color = Color.White)
            Spacer(modifier = Modifier.height(16.dp))
            
            // Glass Button
            Box(
                modifier = Modifier.fillMaxWidth().glassmorphism(16).clickable { /* TODO */ }.padding(16.dp),
                contentAlignment = Alignment.Center
            ) {
                Text("+ Neuen Termin anfragen", color = Color.White, fontWeight = FontWeight.Bold)
            }
            Spacer(modifier = Modifier.height(24.dp))
        }
        
        items(3) { index ->
            val isPast = index > 0
            Box(modifier = Modifier.fillMaxWidth().padding(bottom = 12.dp).glassmorphism(20).padding(20.dp)) {
                Row(horizontalArrangement = Arrangement.SpaceBetween, modifier = Modifier.fillMaxWidth()) {
                    Column {
                        Text(if (!isPast) "Kommend" else "Vergangen", color = if (!isPast) Color(0xFF60a5fa) else Color(0x80FFFFFF), fontSize = 12.sp, fontWeight = FontWeight.Bold)
                        Text(if (!isPast) "IT-Support Session" else "Netzwerk Setup", color = Color.White, fontSize = 16.sp, fontWeight = FontWeight.Bold)
                        Text("Dauer: 2 Stunden", color = Color(0xAAFFFFFF), fontSize = 14.sp)
                    }
                }
            }
        }
    }
}

@Composable
fun InvoicesScreen() {
    LazyColumn(modifier = Modifier.fillMaxSize().padding(horizontal = 24.dp)) {
        item {
            Text("Rechnungen", fontSize = 22.sp, fontWeight = FontWeight.Bold, color = Color.White)
            Spacer(modifier = Modifier.height(16.dp))
        }
        
        items(4) { index ->
            Box(modifier = Modifier.fillMaxWidth().padding(bottom = 12.dp).glassmorphism(20).padding(20.dp)) {
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                    Column {
                        Text("RE-2026-${100 + index}", color = Color.White, fontWeight = FontWeight.Bold)
                        Text(if (index == 0) "Ausstehend" else "Bezahlt", color = if (index == 0) Color(0xFFffcc00) else Color(0xFF34c759), fontSize = 14.sp)
                    }
                    Text("${120 + (index * 15)},00 €", color = Color.White, fontWeight = FontWeight.Bold, fontSize = 18.sp)
                }
            }
        }
    }
}
