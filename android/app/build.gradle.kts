plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.movie_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.movie_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
/*//  flavorDimensions += "default" this is powerful for creating
    flavorDimensions += "default"

    productFlavors {
        create("development") {
            applicationId "com.paras.development" // This is the base applicationId for the development flavor
            dimension = "default"
            manifestPlaceholders = [appName: "development"]
//            applicationIdSuffix = ".dev"  // This will append .dev to the applicationId, making it com.paras.development.dev
        }

        create("staging") {
            applicationId "com.paras.staging" //
            dimension = "default"
            manifestPlaceholders = [appName: 'staging']
//            applicationIdSuffix = ".stg"
        }

        create("production") {
            applicationId "com.paras.movieapp" //
            dimension = "default"
            manifestPlaceholders = [appName: "production"]
//            applicationIdSuffix = ""
        }
    }*/
}

flutter {
    source = "../.."
}
