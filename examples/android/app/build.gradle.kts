plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.plugin.compose")
}
android {
    namespace = "dev.mobwall.demo"
    compileSdk = 36
    defaultConfig {
        applicationId = "dev.mobwall.demo"
        minSdk = 23
        targetSdk = 36
        versionCode = 1
        versionName = "0.1.1"
    }
    buildFeatures { compose = true }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}
kotlin { compilerOptions { jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17) } }
dependencies {
    implementation("androidx.activity:activity-compose:1.9.2")
    implementation("androidx.compose.material3:material3-android:1.2.1")
    implementation("androidx.compose.ui:ui-tooling-preview-android:1.6.8")
    debugImplementation("androidx.compose.ui:ui-tooling-android:1.6.8")
}
