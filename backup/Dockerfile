FROM debian
COPY ./sources.list /etc/apt/sources.list
RUN apt-get update && apt-get -y install cron mysql-server git nano vim

# Github配置
COPY ssh /root/.ssh
RUN chmod 0600 /root/.ssh/id_rsa.pub && chmod 0600 /root/.ssh/id_rsa && chmod 0600 /root/.ssh/known_hosts
RUN git config --global user.name name
RUN git config --global user.email email
RUN mkdir /home/backup
RUN cd /home/backup && git clone git@github.com:user/project.git .

# 配置定时任务
ADD backup.sh /home/backup.sh
RUN chmod 777 /home/backup.sh
ADD cronfile /etc/cron.d/back
RUN chmod 0644 /etc/cron.d/back
RUN crontab /etc/cron.d/back

# 启动定时任务
CMD cron && tail -f /dev/null
