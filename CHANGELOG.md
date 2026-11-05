# Changelog

Alle nennenswerten Änderungen an ORAKEL FC, neueste Version zuerst.
Format nach [Keep a Changelog](https://keepachangelog.com/de/1.1.0/), Versionen nach
[Semantic Versioning](https://semver.org/lang/de/). Die Git-Historie beginnt am 14.08.2026
neu (Stand 1.1.1); Version 1.0.0 ist über ihren Tag weiter erreichbar, von 1.1.0 gibt es
keinen eigenen Commit mehr. Die Versionen ab 1.1.1 wurden nachträglich aus der Git-Historie
zugeordnet; das Datum ist jeweils das des letzten Commits der Version.

| Version | Datum | Das Wichtigste |
|---|---|---|
| [1.3.3](#133--2026-11-05) | 2026-11-05 | Container ohne root, Flask-WTF 1.3.0, Docker-Test in der CI, Doku aufgeräumt |
| [1.3.2](#132--2026-09-26) | 2026-09-26 | gunicorn-Sicherheitsupdate, Start-Test in der CI |
| [1.3.1](#131--2026-09-02) | 2026-09-02 | Sicherheitsrichtlinie, Beitragsleitfaden, CI mit allen Tests |
| [1.3.0](#130--2026-08-16) | 2026-08-16 | Tipp-Vorschlag mit Begründung, Name ohne „2026" |
| [1.2.0](#120--2026-08-15) | 2026-08-15 | Mehrere Turniere parallel, Spielplan-Import für WM/EM/Europapokal, Info-Panel beim Tippen |
| [1.1.1](#111--2026-08-14) | 2026-08-14 | Flask-Sicherheitsupdate |
| [1.1.0](#110--2026-06-22) | 2026-06-22 | Code in Module aufgeteilt, 52 Tests, Betriebsanleitung |
| [1.0.0](#100--2026-06-07) | 2026-06-07 | Erste Version |

## [Unreleased]

## [1.3.3] – 2026-11-05

### Sicherheit
- Der Container läuft nicht mehr als root, sondern als eigener Benutzer `orakel`
  (UID 10001). Ein kleines Startskript übergibt `data/` an diesen Benutzer und gibt dann
  die root-Rechte ab. Bestehende Installationen, deren `data/` noch root gehört, laufen
  daher ohne Handgriff weiter. Der Programmcode im Container ist für die App nicht
  beschreibbar.
- gunicorn startet ohne Control Socket (`--no-control-socket`). Die Fernsteuerung
  `gunicornc` (seit gunicorn 25.1) wird nicht gebraucht; als Nicht-root-Benutzer hätte
  sie bei jedem Start einen Fehler ins Log geschrieben.

### Hinzugefügt
- CI: eigener Docker-Job. Baut das Image, startet es mit einem `data/`-Ordner, der root
  gehört (wie bei alten Installationen), und prüft: Login-Seite antwortet, gunicorn läuft
  als `orakel`, die Daten gehören `orakel`, kein Fehler im Log.
- `.gitattributes`: Shell-Skripte und Dockerfile bleiben auch bei Checkout auf Windows
  bei LF-Zeilenenden.

### Geändert
- Flask-WTF 1.2.1 → 1.3.0.
- `datetime.utcnow()` (seit Python 3.12 veraltet) durch eine gleichwertige Hilfsfunktion
  ersetzt. Gespeicherte Zeiten bleiben unverändert (UTC ohne Zeitzone), die
  124 Deprecation-Warnungen in den Tests sind weg.
- `.dockerignore` schließt Tests, Screenshots und CI-Dateien aus dem Image aus.
- Doku: Screenshots in der README eingeblendet, Testanzahl korrigiert (79), `BETRIEB.md`
  ohne „2026"/„WM", Update per `git pull` statt Zip, Hinweis auf die vorhandene
  „Passwort ändern"-Seite statt „kommt später".

## [1.3.2] – 2026-09-26

### Sicherheit
- gunicorn 22.0.0 → 26.2.0. 22.0.0 ist anfällig für Request Smuggling (CVE-2024-6827,
  behoben ab 23.0.0); 26.x härtet die HTTP-Verarbeitung weiter (Request-Target nach
  RFC 9112, Steuerzeichen in Headern, verbotene Trailer). Die strengeren Regeln lehnen nur
  fehlerhafte oder mehrdeutige Anfragen ab. Entfernt wurde seit 22 der Eventlet-Worker;
  ORAKEL FC nutzt gthread (`-w 1 --threads 4`) und ist davon nicht betroffen.

### Hinzugefügt
- CI: Start-Test mit echtem gunicorn wie im Container. Die App muss starten und die
  Login-Seite ausliefern (vorher prüften die Tests nur die Flask-App direkt).

## [1.3.1] – 2026-09-02

### Hinzugefügt
- `SECURITY.md`, `CONTRIBUTING.md` und CI-Workflow: Syntax-Check und alle Tests auf
  Python 3.11 und 3.12 bei jedem Push.

### Geändert
- Dokumentation mit echten Umlauten statt ae/oe/ue.

## [1.3.0] – 2026-08-16

### Hinzugefügt
- Tipp-Vorschlag im Info-Panel: Ergebnis mit Tendenz aus der Form (Sieg 3, Remis 1,
  Niederlage 0 Punkte, letzte 5 Spiele dieses Turniers), bei knappem Formvergleich
  entscheidet der direkte Vergleich. Nur aus App-eigenen Daten, deutlich als grobe
  Einschätzung ohne Gewähr gekennzeichnet. 4 neue Tests.

### Geändert
- Name „ORAKEL FC 2026" → „ORAKEL FC" (App-Name, Standard-Turnier, Manifest,
  `.env.example`), weil die App nicht mehr nur für die WM gedacht ist. Das GitHub-Repo heißt
  jetzt `orakel-fc` statt `orakel-fc-2026`.

## [1.2.0] – 2026-08-15

### Hinzugefügt
- Mehrere Turniere und Ligen parallel (Competition-Modell): eigene Spiele, Kataloge,
  Tabelle und Mitgliedschaften je Turnier. Bei genau einem aktiven Turnier bleibt die
  Oberfläche wie bisher (kein Umschalter), ab zwei aktiven Turnieren erscheint ein Wechsel
  in der Navigation. Neue Admin-Seite „Turniere". Bestehende Installationen werden beim
  ersten Start automatisch in ein Standard-Turnier übernommen. 5 neue Tests.
- `import_helper.py` (ersetzt `wm2026_import.py`): Spielplan-Import von openfootball mit
  Vorlagen für WM 2026, EM 2024/2028, Champions League, Europa League und Conference League
  (`--list` zeigt alle). Erkennt die Turnier- und Spieltag-Struktur automatisch (auch im
  football.txt-Format), rechnet Anstoßzeiten korrekt in Schweizer Zeit um und warnt vor
  noch offenen Teams und Terminen. 11 neue Tests ohne Netzwerkzugriff.
- Info-Panel pro Spiel auf der Tippen-Seite: bisherige Form beider Teams in diesem
  Turnier, direkter Vergleich und Tipp-Verteilung der Gruppe. Nur aus App-eigenen Daten.
  Die Gruppen-Verteilung wird erst sichtbar, nachdem man selbst getippt hat oder nach
  Anpfiff, damit niemand beeinflusst wird. 6 neue Tests.

### Behoben
- Das letzte aktive Turnier ließ sich archivieren. Danach wäre jede Admin-Seite, auch die
  Turnierverwaltung selbst, mit 403 gesperrt gewesen. Jetzt verhindert, mit Regressionstest.
- Mehrere Seiten zeigten fest „Spieltag" statt der Bezeichnung des Turniers (z. B. „Runde"
  bei Pokalen).

### Entfernt
- Baseldütsch-Übersetzung der README.

## [1.1.1] – 2026-08-14

### Sicherheit
- Flask auf 3.1.3 (CVE-2026-27205).

## [1.1.0] – 2026-06-22

### Hinzugefügt
- 52 Tests mit pytest.
- `BETRIEB.md` (Betriebsanleitung).

### Geändert
- `app.py` in 11 Module aufgeteilt.
- README überarbeitet (Deutsch, Englisch, Baseldütsch).

### Sicherheit
- `SECRET_KEY` ist Pflicht, Schutz vor Open Redirects.

## [1.0.0] – 2026-06-07

### Hinzugefügt
- Tippspiel mit Live-Tabelle, Jokern, Missionen und Challenges.
- CSRF-Schutz, Bremse gegen Passwort-Raten, Sicherheits-Header.
- Docker-Setup, Admin-Bereich, Import des WM-2026-Spielplans.
- Handy-Optimierung, PWA, zweisprachige Dokumentation.

[Unreleased]: https://github.com/kaldox/orakel-fc/compare/v1.3.3...HEAD
[1.3.3]: https://github.com/kaldox/orakel-fc/compare/v1.3.2...v1.3.3
[1.3.2]: https://github.com/kaldox/orakel-fc/compare/v1.3.1...v1.3.2
[1.3.1]: https://github.com/kaldox/orakel-fc/compare/v1.3.0...v1.3.1
[1.3.0]: https://github.com/kaldox/orakel-fc/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/kaldox/orakel-fc/compare/v1.1.1...v1.2.0
[1.1.1]: https://github.com/kaldox/orakel-fc/releases/tag/v1.1.1
[1.0.0]: https://github.com/kaldox/orakel-fc/releases/tag/v1.0.0
