FROM registry.gitlab.com/fdroid/docker-executable-fdroidserver:master

RUN apt-get -y update && \
    apt-get -y dist-upgrade && \
    apt-get -y install python3-pip

# we fetch this specific commit because of this https://github.com/wbond/oscrypto/issues/78
RUN git clone https://github.com/wbond/oscrypto.git && \
    cd oscrypto && \
    git reset --hard 1547f535001ba568b239b8797465536759c742a3 && \
    python3 setup.py install

# we install a recent version of androguard
RUN git clone --recursive https://github.com/androguard/androguard.git && \
    cd androguard && \
    git reset --hard v4.1.2 && \
    pip install . --break-system-packages
