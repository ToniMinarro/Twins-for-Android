# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/USER/Library/Android/sdk/tools/proguard/proguard-android-optimize.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you are using Gson add this condition to avoid crashing when GSON
# tries to access private fields.
#-keepattributes InnerClasses
#-keep public class * extends java.lang.Exception
