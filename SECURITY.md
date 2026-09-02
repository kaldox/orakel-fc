# Security Policy

> English version below · [Deutsche Version](#sicherheitsrichtlinie)

## Reporting a Vulnerability

Found a security issue in **ORAKEL FC**? Please report it privately, not as a
public issue:

1. Go to the [Security tab](https://github.com/kaldox/orakel-fc/security) of this repository
2. Click **"Report a vulnerability"** to open a private GitHub Security Advisory
3. Describe the issue: what it is, how to reproduce it, and its impact

You'll get an acknowledgement and, once a fix is ready, credit in the advisory
(unless you'd rather stay anonymous).

## Scope

**In scope** – vulnerabilities in ORAKEL FC's own code, e.g.:
- Authentication / session handling (login bypass, privilege escalation to
  admin, session fixation)
- CSRF, open redirect, or injection (SQL, template, header)
- One player reading or changing another player's tips, jokers, or score
- The JSON schedule import or catalog editor executing unintended code

**Out of scope:**
- Running the app without the reverse proxy / HTTPS setup described in
  `BETRIEB.md`
- Vulnerabilities in third-party components (Flask, SQLAlchemy, gunicorn) –
  please report those upstream
- Missing rate limiting on endpoints other than login

## Supported Versions

Only the latest release is supported with security fixes. Always update to the
newest version.

## Response

ORAKEL FC is a hobby project maintained in spare time – no guaranteed response
time or SLA, but security reports get priority over features and regular bugs.

---

## Sicherheitsrichtlinie

## Eine Schwachstelle melden

Eine Sicherheitslücke in **ORAKEL FC** gefunden? Bitte privat melden, nicht als
öffentliches Issue:

1. Zum [Security-Tab](https://github.com/kaldox/orakel-fc/security) dieses Repos gehen
2. **"Report a vulnerability"** klicken – öffnet einen privaten GitHub Security Advisory
3. Beschreiben: was ist das Problem, wie reproduziert man es, welche Auswirkung hat es

Du bekommst eine Rückmeldung und, sobald ein Fix bereitsteht, eine Nennung im
Advisory (auf Wunsch auch anonym).

## Umfang

**Relevant** – Schwachstellen im eigenen ORAKEL-FC-Code, z.B.:
- Authentifizierung / Session-Handling (Login-Bypass, Rechteausweitung zum
  Admin, Session-Fixation)
- CSRF, Open Redirect oder Injection (SQL, Template, Header)
- Eine Person liest oder ändert Tipps, Joker oder Punkte einer anderen
- Der JSON-Spielplan-Import oder Katalog-Editor führt unbeabsichtigten Code aus

**Nicht relevant:**
- Betrieb ohne den in `BETRIEB.md` beschriebenen Reverse-Proxy-/HTTPS-Aufbau
- Schwachstellen in Drittkomponenten (Flask, SQLAlchemy, gunicorn) – bitte
  dort melden
- Fehlendes Rate-Limiting an anderen Endpunkten als dem Login

## Unterstützte Versionen

Nur die jeweils aktuellste Version bekommt Sicherheits-Fixes. Immer auf die
neueste Version aktualisieren.

## Reaktionszeit

ORAKEL FC ist ein Hobby-Projekt, gepflegt in der Freizeit – keine garantierte
Reaktionszeit oder SLA, aber Sicherheitsmeldungen haben Vorrang.
