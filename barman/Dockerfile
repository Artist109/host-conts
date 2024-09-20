FROM postgres:16-bookworm

RUN apt-get update &&  \
    apt-get install	barman=3.10.0-1 python3-pip && \
    apt-get clean &&

COPY barman.conf /etc/barman.d/mydb.conf

# ��������� SSH
# ����������� ���������� SSH ����� �� �������
# ���������� StrictHostKeyChecking
# ��������� ��������� ������������ SSH
RUN mkdir -p /home/barman/.ssh && chmod 700 /home/barman/.ssh && \
    --mount=type=secret,id=ssh_private_key \
    cp /run/secrets/ssh_private_key /home/barman/.ssh/id_rsa && \
    chmod 600 /home/barman/.ssh/id_rsa && \
    chown -R barman:barman /home/barman/.ssh && \
    echo "Host *\n\tStrictHostKeyChecking no\n" > /home/barman/.ssh/config && \
    RUN chown -R barman:barman /home/barman/.ssh/config

CMD ["barman", "start"]