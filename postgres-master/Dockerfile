FROM postgres:16-bookworm

RUN apt-get update && apt-get install -y  \
    cron \
    openssh-server \
    iputils-ping \
    nano && \
    rm -rf /var/lib/apt/lists/*
#    mkdir /var/run/sshd && \
#    useradd -m barman && \
#    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
#    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

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

EXPOSE 5432
EXPOSE 22

#CMD ["/usr/sbin/sshd", "-D"]