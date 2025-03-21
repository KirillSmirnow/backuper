FROM postgres
RUN apt update && apt install -y ssh
COPY keys/id_backuper.pub /root/.ssh/authorized_keys
CMD /etc/init.d/ssh start && /usr/local/bin/docker-entrypoint.sh postgres
