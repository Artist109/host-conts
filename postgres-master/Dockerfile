FROM postgres:16-bookworm

RUN apt-get update && apt-get install -y  \
    cron \
    openssh-server \
    iputils-ping \
    nano

#RUN useradd -m replicator

#ARG REPLICATOR_PASSWORD=replicator_password
#RUN echo "replicator:${REPLICATOR_PASSWORD}" | chpasswd

#RUN mkdir /home/replicator/.ssh && chmod 700 /home/replicator/.ssh

#COPY ./secrets/ssh_private_key.pub /home/replicator/.ssh/authorized_keys
#RUN chmod 600 /home/replicator/.ssh/authorized_keys && chown -R replicator:replicator /home/replicator/.ssh

#RUN echo "PermitRootLogin no" >> /etc/ssh/sshd_config
#RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
#RUN echo "UsePAM yes" >> /etc/ssh/sshd_config

#RUN mkdir /var/run/sshd

COPY init_db.sh /docker-entrypoint-initdb.d/init_db.sh

COPY conf/pg_hba.conf /var/lib/postgresql/conf/
COPY conf/postgresql.conf /var/lib/postgresql/conf/

#EXPOSE 22

EXPOSE 5432

USER postgres

CMD ["postgres"]