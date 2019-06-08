FROM debian
MAINTAINER liangjinbiao@live.com

COPY ./sources.list /etc/apt/sources.list
RUN apt-get update && apt-get -y install cron mysql-server git wget zip

RUN mkdir -p /home/config && mkdir -p /home/upload && mkdir -p /home/backup

COPY ./upload /home/upload

VOLUME /home/config /home/backup

# Github Configure
ARG GITHUB=false
ENV QINIU_UPLOAD=${QINIU}
RUN if [ ${GITHUB} != false ]; then \
    COPY /home/config/github /root/.ssh \
    RUN chmod 0600 /root/.ssh/id_rsa.pub && chmod 0600 /root/.ssh/id_rsa && chmod 0600 /root/.ssh/known_hosts \
    RUN git config --global user.name name \
    RUN git config --global user.email email \
    RUN git clone git@github.com:user/project.git /home/backup
;fi

# 七牛 Configure
ARG QINIU=false
ENV QINIU_UPLOAD=${QINIU}
ARG QINIU_AK
ARG QINIU_SK
RUN if [ ${QINIU} != false ]; then \
    mkdir -p /qshell \
    && wget http://devtools.qiniu.com/qshell-v2.3.6.zip \
    && unzip qshell-v2.3.6.zip \
    && ln ./qshell_linux_x64 /usr/local/bin/qshell \
    && qshell account ${QINIU_AK} ${QINIU_SK} uploader \
;fi

WORKDIR /home/backup

# 配置定时任务
ADD backup.sh /home/backup.sh
RUN chmod 777 /home/backup.sh
ADD cronfile /etc/cron.d/back
RUN chmod 0644 /etc/cron.d/back
RUN crontab /etc/cron.d/back

# 启动定时任务
CMD cron && tail -f /dev/null
