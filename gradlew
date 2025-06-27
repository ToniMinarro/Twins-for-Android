#!/bin/sh
##############################################################################
##
##  Gradle start up script for UN*X
##
##############################################################################

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS=""

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/bin/java" ] ; then
        JAVACMD="$JAVA_HOME/bin/java"
    else
        echo "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME" >&2
        exit 1
    fi
else
    JAVACMD="java"
fi

# Locate the wrapper jar file
WRAPPER_JAR="$(dirname "$0")/gradle/wrapper/gradle-wrapper.jar"

# Locate the wrapper properties file
WRAPPER_PROPERTIES="$(dirname "$0")/gradle/wrapper/gradle-wrapper.properties"

# Execute Gradle wrapper
exec "$JAVACMD" $DEFAULT_JVM_OPTS -cp "$WRAPPER_JAR" org.gradle.wrapper.GradleWrapperMain "$@"
