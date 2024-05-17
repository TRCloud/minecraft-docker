ARG IMAGE_BASE=azul/zulu-openjdk-debian
ARG JAVA=17
FROM ${IMAGE_BASE}:${JAVA}-latest

# Change mirrors
RUN sed \
        -i.bak \
        -e 's/deb.debian.org/mirrors.cernet.edu.cn/g' \
        -e 's|security.debian.org/debian-security|mirrors.cernet.edu.cn/debian-security|g' \
        /etc/apt/sources.list; \
    apt-get update -y; \
    apt-get install -y -f curl ca-certificates openssl git tar sqlite3 fontconfig tzdata iproute2 gettext-base wget;

# Install Python 3.12 for MCDR
ARG TYPE
ARG PYTHON=3.12.3
RUN if [ "${TYPE}" = "python" ]; then \
        apt-get install -y build-essential libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev; \
        cd /tmp; \
        wget https://www.python.org/ftp/python/${PYTHON}/Python-${PYTHON}.tgz; \
        tar -xzvf Python-${PYTHON}.tgz; \
        cd Python-${PYTHON}; \
        ./configure --enable-optimizations; \
        make -j 8; \
        make altinstall; \
    fi;

# Install MCDR and requirements
COPY requirements.txt /requirements.txt 
ARG TYPE
ARG MCDR_REQUIREMENT=mcdreforged
RUN if [ "${TYPE}" = "python" ]; then \
        python3.12 -m pip install -U pip; \
        python3.12 -m pip install ${MCDR_REQUIREMENT}; \
        python3.12 -m pip install -r /requirements.txt; \
    fi;

# Clean up
ARG TYPE
RUN if [ "${TYPE}" = "python" ]; then \
        cd /tmp; \
        python3.12 -m pip cache purge; \
        rm -rf /requirements.txt; \
        rm -rf /tmp/Python-${PYTHON}; \
        rm -rf /tmp/Python-${PYTHON}.tgz; \
        apt-get remove -y build-essential libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev; \
    fi; \
    apt-get autoremove -y; \
    apt-get clean;

RUN useradd -d /home/container -m container;
USER container
RUN useradd -d /home/container -m container;
ENV USER=container HOME=/home/container

WORKDIR /workspace
COPY ./entrypoint.sh /
CMD ["/bin/bash", "/entrypoint.sh"]
