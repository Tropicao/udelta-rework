FROM base/archlinux

RUN pacman --noconfirm -Syuu
RUN pacman --noconfirm -S sudo vim
RUN useradd -ms /bin/bash emotion-tech
ADD . /opt/RepetierHost
WORKDIR /opt/RepetierHost
USER emotion-tech

CMD ./configureFirst.sh
