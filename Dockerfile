FROM mdcw/tccodefresh
RUN ls && \
whoami && \
pwd && \
ifconfig && \
uname -a
