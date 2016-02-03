# Duply mit docker

## Image erzeugen

``./build.sh``

## Image Befehle

Das Image erwartet als Parameter einen Befehl. Das Skript ``cmd.sh`` kümmert sich um die Datei-Mounts und Übergabe des Befehls.

``cmd.sh`` erwartet als ersten Parameter ein Arbeitsverzeichnis. Hier werden der gpg Schlüssel und das duply Projekt gespeichert. Als zweiten Parameter das Verzeichnis, welches die Dateien, die gesichert werden sollen, enthält. In den folgenden Beispielen wird /settings und /files-to-backup angenommen. Dritter Parameter ist der Befehl der im entrypoint verarbeitet wird.

### gpg-init

``./cmd.sh /settings und /files-to-backup gpg-init``

Erzeugt die Schlüssel. Diese liegen dann unter ``/settings``

### duply-init

``./cmd.sh /settings und /files-to-backup duply-init my-project``

Erzeugt das Duply Projekt. Es kopiert dabei die Keys in das Projekt-Verzeichnis ``/settings/my-project`` und trägt die Schlüssel ID schon in die ``/settings/my-project/conf`` ein.
Danach sollte man gleich mit ```sudo nano /settings/my-project/conf``` zumindest die Parameter ``GPG_PW``, ``SOURCE``, ``TARGET`` und ``MAX_AGE``setzen. Die ``/files-to-backup`` sind im Container unter ``/mnt`` eingebunden.

### duply-run

``./cmd.sh /settings und /files-to-backup duply-run my-project``

Führt das Backup aus und sollte wenn es funktioniert in cron eingetragen werden.
