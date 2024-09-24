FROM unit@sha256:1ea9232c65e1dd9df0b9789e5e96b159afd0059cd211a52347fad735dc2d5f5c

RUN apt-get update && apt-get install -y \
    python3-pip \
    libpq-dev \
    python3-venv \
    postgresql-client  \
    iputils-ping \
    nano && \
    pip install psycopg2-binary Flask==2.2.2 Werkzeug==2.2.2 && \
    rm -rf /var/lib/apt/lists/*
    # git clone https://gitlab.fbsvc.bz/rnd/test_assignments/sfadeev.git .

WORKDIR /srv/nginx-unit
COPY . /srv/nginx-unit

RUN python3 -m venv app-flask && \
    /bin/bash -c "source app-flask/bin/activate && pip install --no-cache-dir -r requirements.txt"
COPY unit-config.json /docker-entrypoint.d/unit-config.json

#RUN chown -R www-data:www-data /nginx-unit /var/log/unit.log

#USER www-data

EXPOSE 8300

CMD ["unitd", "--no-daemon", "--control", "0.0.0.0:8080"]