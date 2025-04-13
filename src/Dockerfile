FROM alpine
WORKDIR /root
RUN apk add apk-cron openssh-client
COPY initialize.sh .
COPY backup.sh .
CMD ./initialize.sh && crond && tail -n0 -f /root/*.log
