# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /usr/local/android-studio/gradle/wrapper/gradle-5.4.1/bin/proguard-android-optimize.txt
# You can find more settings in http://developer.android.com/tools/help/proguard.html

# Add any project-specific ProGuard rules here.
# For Capacitor, typically very few rules are needed.
# This is a good starting point for a simple app.

-keep class com.getcapacitor.** { *; }
-keep class com.getcapacitor.community..** { *; }
-keep class * implements com.getcapacitor.JSObject { *; }

# Don't warn about missing LineNumberTable attributes (needed for stack traces)
-dontwarn java.lang.Object # May occur if app is targeting a higher API level

# If you're using specific plugins, they might have their own ProGuard rules to add here.
# For example, if using Firebase:
# -keep class com.google.firebase.** { *; }
# -keep class com.google.android.gms.** { *; }
