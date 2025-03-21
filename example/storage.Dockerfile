FROM ubuntu
RUN apt update && apt install -y ssh tree
COPY keys/id_backuper.pub /root/.ssh/authorized_keys
CMD /etc/init.d/ssh start && while true; do tree /storage; sleep 15; done
