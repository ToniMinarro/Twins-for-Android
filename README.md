# Twins for Android

Este es un proyecto Android de ejemplo.

## Entorno de Desarrollo con Docker y Makefile

Este proyecto incluye una configuración de Docker y un `Makefile` para facilitar un entorno de desarrollo consistente y simplificar la ejecución de comandos comunes.

### Prerrequisitos

- Docker Desktop (o Docker Engine en Linux) instalado.
- `make` instalado.

### Usando el Makefile

El `Makefile` proporciona atajos para varias operaciones comunes. Para ver todos los comandos disponibles, ejecuta:

```bash
make help
```

A continuación, algunos de los comandos más útiles:

- **Construir la imagen Docker:**
  ```bash
  make build
  ```

- **Abrir un shell interactivo en el contenedor:**
  ```bash
  make shell
  # o
  make bash
  ```
  Una vez dentro, puedes navegar a `/app` y ejecutar comandos como `./gradlew tasks`.

- **Construir el APK de depuración:**
  ```bash
  make debug
  # o (alias)
  make assemble
  ```
  Los APKs generados se encontrarán en `app/build/outputs/apk/debug/`.

- **Construir el APK de release:**
  ```bash
  make release
  ```
  Los APKs generados se encontrarán en `app/build/outputs/apk/release/`.

- **Ejecutar pruebas unitarias:**
  ```bash
  make test-unit
  # o (alias)
  make test
  ```

- **Limpiar el proyecto Gradle:**
  ```bash
  make clean
  ```

### Configuración de Docker (Detalles)

Si no deseas usar `make`, puedes interactuar directamente con Docker y Docker Compose.

#### Construir la imagen Docker

Para construir la imagen Docker manualmente, ejecuta:

```bash
docker-compose build
```
o si prefieres no usar `docker-compose` para este paso:
```bash
docker build -t my-android-app .
```

#### Ejecutar tareas Gradle manualmente

Puedes ejecutar comandos de Gradle dentro del contenedor Docker. Por ejemplo, para construir el APK de depuración usando Docker Compose:
```bash
docker-compose run --rm android-app ./gradlew :app:assembleDebug
```

#### Desarrollo Interactivo Manual

Para un shell interactivo dentro del contenedor usando Docker Compose:
```bash
docker-compose run --rm android-app bash
```

### Notas Adicionales

- Los cambios en el código fuente en tu máquina local se reflejarán dentro del contenedor gracias a los volúmenes montados en `docker-compose.yml`.
- Las dependencias de Gradle se almacenan en un volumen (`gradle_cache`) para persistir entre ejecuciones y acelerar las compilaciones posteriores.
- **Ejecutar Emuladores/Dispositivos:** Esta configuración de Docker está principalmente orientada a la compilación y ejecución de tareas de Gradle. Ejecutar un emulador de Android directamente dentro de este contenedor Docker es complejo y generalmente no se recomienda para el desarrollo diario. Es más común construir el APK dentro de Docker y luego instalarlo en un emulador o dispositivo que se ejecuta en tu máquina host o a través de servicios de pruebas en la nube. Si necesitas conectar ADB a un dispositivo o emulador en tu host desde dentro del contenedor, esto requeriría configuración de red adicional (por ejemplo, `network_mode: "host"` en Docker Compose en Linux, o configuraciones más complejas para Mac/Windows).
