FROM mdcw/tccodefresh

RUN echo "test1" &&\
pwd &&\
ls /etc/nginx &&\
uname -a &&\
whoami &&\
ifconfig

