FROM centos:latest
RUN cat /etc/centos-release

# for the wolfram-engine rpm itself

RUN yum -y install perl
RUN yum -y install alsa-lib
RUN yum -y install git
RUN yum -y install wget
RUN yum -y install avahi
RUN systemctl enable avahi-daemon

RUN yum -y groupinstall --allowerasing "Minimal Install"

# wolfram-engine
RUN wget -O WolframEngine_12.2.0_LIN.sh "https://files.wolframcdn.com/WolframEngine/12.2.0.0/WolframEngine_12.2.0_LIN.sh?4ae6ee529e4e0d5967853e906cb23dfea4455a532e3a25e0d5e4cdb02f58d44bb7a9ff30085fa4955ca8f341845676a850ccd5920603fcbf77499169152e824a8fc56539844ccd11bde5483f18c399a1fe187bc8dfdbc0e26601a1c2205498c04a6b9aLINUX_.sh"
RUN /bin/sh /WolframEngine_12.2.0_LIN.sh

# define user

RUN useradd -ms /bin/bash wolfram
USER wolfram
WORKDIR /home/wolfram

RUN ssh-keygen -t ECDSA -N "" -f ~/.ssh/dockerecdsa
RUN cat ~/.ssh/dockerecdsa.pub
CMD bash
