#!/bin/bash
set -e

mkdir -p .github/workflows
mkdir -p app/src/main/java/info/witting/app/ui/theme
mkdir -p app/src/main/res/values
mkdir -p app/src/main/res/drawable

# Workflow
cat << 'YML' > .github/workflows/build.yml
name: Android CI
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: set up JDK 17
      uses: actions/setup-java@v3
      with:
        java-version: '17'
        distribution: 'temurin'
    - name: Setup Gradle
      uses: gradle/gradle-build-action@v2
      with:
        gradle-version: '8.4'
    - name: Build APK
      run: gradle assembleDebug --no-daemon
    - name: Upload APK
      uses: actions/upload-artifact@v3
      with:
        name: witting-app-debug
        path: app/build/outputs/apk/debug/app-debug.apk
YML

# Root Build
cat << 'BLD' > build.gradle.kts
plugins {
    id("com.android.application") version "8.1.1" apply false
    id("org.jetbrains.kotlin.android") version "1.9.10" apply false
}
BLD

# Settings
cat << 'SET' > settings.gradle.kts
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "WittingApp"
include(":app")
SET

# Gradle properties
cat << 'GRP' > gradle.properties
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.useAndroidX=true
android.nonTransitiveRClass=true
GRP

# App Build
cat << 'ABL' > app/build.gradle.kts
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}
android {
    namespace = "info.witting.app"
    compileSdk = 34
    defaultConfig {
        applicationId = "info.witting.app"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
        vectorDrawables { useSupportLibrary = true }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }
    buildFeatures { compose = true }
    composeOptions { kotlinCompilerExtensionVersion = "1.5.3" }
}
dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.6.2")
    implementation("androidx.activity:activity-compose:1.8.0")
    implementation(platform("androidx.compose:compose-bom:2023.10.01"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-graphics")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.navigation:navigation-compose:2.7.4")
}
ABL

# Manifest
cat << 'MAN' > app/src/main/AndroidManifest.xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <application
        android:allowBackup="true"
        android:label="Witting.info"
        android:theme="@style/Theme.WittingApp">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:theme="@style/Theme.WittingApp">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
MAN

# Themes
cat << 'THM' > app/src/main/res/values/themes.xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.WittingApp" parent="android:Theme.Material.Light.NoActionBar" />
</resources>
THM

# Theme.kt
cat << 'TKT' > app/src/main/java/info/witting/app/ui/theme/Theme.kt
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
TKT

# MainActivity.kt
cat << 'MAK' > app/src/main/java/info/witting/app/MainActivity.kt
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
MAK

