FROM base/archlinux

RUN pacman --noconfirm -Syuu
RUN pacman --noconfirm -S sudo vim
RUN useradd -ms /bin/bash emotion
RUN passwd -d emotion
RUN echo "emotion ALL=(ALL) ALL" > /etc/sudoers.d/user && chmod 0440 /etc/sudoers.d/user
ADD . /opt/RepetierHost
WORKDIR /opt/RepetierHost
USER emotion

CMD ./configureFirst.sh
