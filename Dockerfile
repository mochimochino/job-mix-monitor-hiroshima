FROM almalinux:8

RUN dnf install -y \
    git \
    java-11-openjdk-devel \
    python2 \
    wget \
    && dnf clean all

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk

WORKDIR /app

RUN git clone https://github.com/mochimochino/job-mix-monitor-hiroshima.git .

RUN chmod +x ./update_mlclient.sh ./bin/recompile.sh ./run_client.sh ./scripts/eval_jobmix.py

RUN echo "/usr/lib/jvm/java-11-openjdk" > conf/env.JAVA_HOME

RUN ./update_mlclient.sh

RUN cd bin && ./recompile.sh

CMD ["/bin/bash"]