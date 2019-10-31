FROM ubuntu:18.04

# SET NONINTERACTIVE
ENV DEBIAN_FRONTEND "noninteractive"

RUN apt update && \
    apt install -y \
    curl \
    gpg \
    coreutils \
    tree \
    nano \
    net-tools \
    locate \
    bsdmainutils \
    netcat-openbsd \
    apt-transport-https

RUN apt update \
    && apt install -y \
    libnotify4 \
    libnss3 \
    libxkbfile1 \
    libgconf-2-4 \
    libsecret-1-0 \
    libgtk2.0-0 \
    libxss1 \
    libasound2 \
    libcanberra-gtk-module \
    gtk2-engines-murrine \
    gtk2-engines-pixbuf \
    ubuntu-mate-icon-themes \
    ubuntu-mate-themes

RUN apt install -y \
    libx11-xcb-dev \
    pkg-config \
    xdg-utils \
    dbus-x11

RUN apt install -y wget

RUN mkdir -p /var/run/dbus

RUN apt update && \
    apt install -y \
    git \
    gcc-8 \
    g++-8 \
    cmake

RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 50 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 50 && \
    update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-8 50 && \
    update-alternatives --set g++ /usr/bin/g++-8 && \
    update-alternatives --set gcc /usr/bin/gcc-8 && \
    update-alternatives --set cpp-bin /usr/bin/cpp-8 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-8 50

RUN useradd -m andrei
ENV USER andrei
WORKDIR /home/andrei/

RUN wget https://download.jetbrains.com/cpp/CLion-2019.2.5.tar.gz -O /tmp/CLion-2019.2.5.tar.gz && \
    mkdir /app && \
    cd /app && tar -xvf /tmp/CLion-2019.2.5.tar.gz && \
    mv "/app/`ls /app`" /app/clion

RUN apt update && \
    wget https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init -O rustup-init && \
    chmod +x rustup-init

RUN echo 'include "/usr/share/themes/Ambiant-MATE/gtk-2.0/gtkrc"' > /home/andrei/.gtkrc-2.0

RUN echo "root:root" | chpasswd

USER andrei

RUN ./rustup-init -y

COPY .bashrc .bashrc

RUN /home/andrei/.cargo/bin/rustup component add rust-analysis --toolchain stable-x86_64-unknown-linux-gnu && \
    /home/andrei/.cargo/bin/rustup component add rust-src --toolchain stable-x86_64-unknown-linux-gnu && \
    /home/andrei/.cargo/bin/rustup component add rls --toolchain stable-x86_64-unknown-linux-gnu

CMD ["/bin/bash", "--login", "/app/clion/bin/clion.sh"]
