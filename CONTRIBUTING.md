# Contributing to ORAKEL FC

> English version below · [Deutsche Version](#beitragen-zu-orakel-fc)

Thanks for considering a contribution! ORAKEL FC is a hobby project maintained
in spare time, so please be patient with reviews – but contributions are
genuinely welcome.

## Before you start

For anything beyond a small fix, open an issue first to discuss the approach.
For bugs, a minimal reproduction helps a lot.

## Development setup

```bash
git clone https://github.com/kaldox/orakel-fc.git
cd orakel-fc
python3 -m venv .venv && . .venv/bin/activate
pip install -r requirements.txt pytest
python3 -m pytest tests/
```

The test suite sets its own `SECRET_KEY` / `ADMIN_PASSWORD` defaults, uses an
in-memory SQLite DB per test and never touches a real `orakel.db`.

## Workflow

- **One feature/fix = one branch = one PR.** Branch off `main`, e.g.
  `feat/knockout-bonus` or `fix/open-redirect-login`.
- **Tests are not optional.** New features need tests; bugfixes need a
  regression test that fails without the fix. Run `python3 -m pytest tests/`
  before opening a PR – it must be clean.
- **Keep both languages in sync.** ORAKEL FC ships an EN/DE UI; user-facing
  strings go through `i18n`. README changes go into `README.md` **and**
  `README.en.md`.
- **Update the CHANGELOG.** New feature or fix → a line under `[Unreleased]`
  in `CHANGELOG.md`.
- **No personal data in the codebase.** No real names, emails, or credentials,
  even in fixtures.

## Commit messages

German, matching the existing history – short, imperative, one line:

```
Mehrere Turniere/Ligen parallel unterstützen
Open-Redirect beim Login schliessen
README: Wertungsregeln präzisiert
```

## Security-relevant code

Changes to `auth.py`, `security.py`, or the session/cookie setup should
preserve the existing hardening: CSRF protection, the login brute-force brake,
the security headers, and hardened session cookies.

## License

By contributing, you agree your contribution is licensed under the project's
[MIT License](LICENSE).

---

## Beitragen zu ORAKEL FC

Danke fürs Interesse! ORAKEL FC ist ein Hobby-Projekt, gepflegt in der Freizeit
– etwas Geduld bei Reviews ist hilfreich, aber Beiträge sind ausdrücklich
willkommen.

## Bevor du startest

Für alles über einen kleinen Fix hinaus: bitte erst ein Issue aufmachen und den
Ansatz besprechen. Bei Bugs hilft eine minimale Reproduktion sehr.

## Entwicklungsumgebung einrichten

```bash
git clone https://github.com/kaldox/orakel-fc.git
cd orakel-fc
python3 -m venv .venv && . .venv/bin/activate
pip install -r requirements.txt pytest
python3 -m pytest tests/
```

Die Testsuite setzt ihre eigenen `SECRET_KEY`/`ADMIN_PASSWORD`-Defaults, nutzt
pro Test eine In-Memory-SQLite-DB und rührt nie an einer echten `orakel.db`.

## Ablauf

- **Ein Feature/Fix = ein Branch = ein PR.** Von `main` abzweigen, z.B.
  `feat/knockout-bonus` oder `fix/open-redirect-login`.
- **Tests sind nicht optional.** Neue Features brauchen Tests, Bugfixes einen
  Regressionstest, der ohne den Fix fehlschlägt. Vor jedem PR
  `python3 -m pytest tests/` – muss sauber durchlaufen.
- **Beide Sprachen synchron halten.** ORAKEL FC hat ein EN/DE-UI;
  nutzersichtbare Strings laufen über `i18n`. README-Änderungen in
  `README.md` **und** `README.en.md`.
- **CHANGELOG aktualisieren.** Neues Feature oder Fix → eine Zeile unter
  `[Unreleased]` in `CHANGELOG.md`.
- **Keine personenbezogenen Daten im Code.** Keine echten Namen, E-Mails oder
  Zugangsdaten, auch nicht in Fixtures.

## Commit-Messages

Deutsch, wie in der bestehenden Historie – kurz, im Imperativ, einzeilig:

```
Mehrere Turniere/Ligen parallel unterstützen
Open-Redirect beim Login schliessen
README: Wertungsregeln präzisiert
```

## Sicherheitsrelevanter Code

Änderungen an `auth.py`, `security.py` oder am Session-/Cookie-Setup sollten die
bestehende Härtung erhalten: CSRF-Schutz, Login-Bruteforce-Bremse,
Sicherheitsheader und gehärtete Session-Cookies.

## Lizenz

Mit einem Beitrag stimmst du zu, dass er unter der [MIT-Lizenz](LICENSE) des
Projekts steht.
