#!/bin/sh
# Startet ORAKEL FC als unprivilegierter Benutzer "orakel".
#
# Als root gestartet (Normalfall): Der Datenordner wird dem App-Benutzer
# übergeben, dann gibt das Skript die root-Rechte ab. So laufen auch ältere
# Installationen weiter, deren data/ (Bind-Mount) noch root gehört.
# Wer den Container selbst mit "user:" startet, landet direkt im else-Zweig.
set -e

if [ "$(id -u)" = "0" ]; then
    chown -R orakel:orakel /app/data
    exec setpriv --reuid=orakel --regid=orakel --init-groups "$@"
fi

exec "$@"
