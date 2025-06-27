# Usar una imagen base con Android SDK. Asegúrate de que la versión coincida con tu compileSdk.
FROM androidsdk/android-31

# Variables de entorno para Android SDK
ENV ANDROID_SDK_ROOT /opt/android-sdk-linux
ENV PATH $PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator

# Instalar herramientas de compilación y otras dependencias si es necesario.
# La imagen base androidsdk/android-31 ya debería tener la mayoría de lo necesario.
# RUN sdkmanager "system-images;android-31;google_apis;x86_64" # Ejemplo si necesitaras una imagen de sistema específica
# RUN sdkmanager "platforms;android-31" "build-tools;31.0.2" # Ejemplo para instalar build-tools específicas

# Crear directorio de la aplicación
WORKDIR /app

# Copiar los archivos de Gradle
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY app/build.gradle app/

# Otorgar permisos de ejecución a gradlew
RUN chmod +x ./gradlew

# Descargar dependencias de Gradle.
# Esto se hace como un paso separado para aprovechar el almacenamiento en caché de capas de Docker.
# Copia solo los archivos necesarios para resolver dependencias primero.
COPY app/src/main/AndroidManifest.xml app/src/main/AndroidManifest.xml
# Intenta ejecutar una tarea que resuelva dependencias
RUN ./gradlew :app:dependencies || echo "Failed to download dependencies, but continuing to copy source."

# Copiar el resto del código fuente de la aplicación
COPY app/src app/src
COPY app/proguard-rules.pro app/proguard-rules.pro

# El comando por defecto podría ser construir el proyecto o iniciar un shell
# Por ahora, un comando simple para verificar.
CMD ["./gradlew", ":app:assembleDebug"]
