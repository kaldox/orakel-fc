FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Eigener Benutzer ohne Login-Shell; die App läuft nicht als root.
RUN useradd --system --uid 10001 --user-group --no-create-home --shell /usr/sbin/nologin orakel

COPY . .
RUN mkdir -p /app/data && chown orakel:orakel /app/data

EXPOSE 8090

# Das Entrypoint-Skript übergibt data/ an "orakel" und gibt dann root ab.
ENTRYPOINT ["sh", "/app/docker-entrypoint.sh"]

# 1 Worker + Threads: SQLite verträgt nur einen schreibenden Prozess gut.
# Für 5-15 Mitspieler:innen ist das mehr als ausreichend.
# --no-control-socket: Die Fernsteuerung "gunicornc" (seit gunicorn 25.1) wird
# nicht gebraucht und bräuchte ein beschreibbares Home-Verzeichnis.
CMD ["gunicorn", "-w", "1", "--threads", "4", "--no-control-socket", "-b", "0.0.0.0:8090", "app:app"]
