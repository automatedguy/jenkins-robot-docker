FROM jenkins/jenkins

USER root

# Update & Upgrade OS
RUN apt-get update \
 && apt-get -y upgrade

# Add Maven
RUN apt-get -y install maven --no-install-recommends

# Add Docker
RUN curl -sSL https://get.docker.com/ | sh

# Install tools required for compiling Python 3.6.1 and wget for installing pip3
RUN apt-get update -y && \
        apt-get upgrade -y

RUN apt-get install -y \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libgdbm-dev \
        libdb5.3-dev \
        libbz2-dev \
        libexpat1-dev \
        liblzma-dev \
        tk-dev \
        wget

# Copy sh script responsible for installing Python
COPY installpython3.sh /root/tmp/installpython3.sh

# Run the script responsible for installing Python 3.6.1 and link it to /usr/bin/python3
RUN chmod +x /root/tmp/installpython3.sh; sync && \
        ./root/tmp/installpython3.sh && \
        rm -rf /root/tmp/installpython3.sh && \
        ln -s /Python-3.6.1/python /usr/bin/python3

RUN pip3 install robotframework
