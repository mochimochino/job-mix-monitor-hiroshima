FROM almalinux:9

RUN dnf -y install epel-release && \
    dnf -y install java-11-openjdk-devel python3 python3-pip git wget && \
    dnf clean all

WORKDIR /opt/job-mix-monitor

COPY . .

RUN echo "/usr/lib/jvm/java-11-openjdk" > conf/env.JAVA_HOME

RUN chmod +x update_mlclient.sh && ./update_mlclient.sh

RUN chmod +x bin/recompile.sh && cd bin && ./recompile.sh

CMD ["./run_client.sh", "mysite", "output.txt"]

