FROM    ubuntu:20.04
# Make sure the package repository is up to date
RUN     apt-get update

# Install vnc, xvfb in order to create a 'fake' display and firefox
RUN     apt-get install -y x11vnc xvfb 
RUN     mkdir ~/.vnc
# Setup a password
RUN     x11vnc -storepasswd 1234 ~/.vnc/passwd
# Autostart firefox (might not be the best way to do it, but it does the trick)

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
	nano \
	wget \
	git \
	unzip \
	gnupg2

# Install Boring Man and bmanage
RUN dpkg --add-architecture i386
RUN apt-get install && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key \
	&& apt-key add winehq.key
RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
RUN apt install -y  --install-recommends winehq-stable 
COPY manage.sh /manage.sh
COPY bm_server.ini /bm_server.ini 
RUN chmod +x manage.sh
EXPOSE 42069/udp
RUN ["/manage.sh", "install" ]
CMD ["/manage.sh", "start"]
