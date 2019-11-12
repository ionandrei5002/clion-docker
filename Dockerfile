FROM ui-base-docker:latest

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

RUN wget https://download.jetbrains.com/cpp/CLion-2019.2.5.tar.gz -O /tmp/CLion-2019.2.5.tar.gz && \
    mkdir /app && \
    cd /app && tar -xvf /tmp/CLion-2019.2.5.tar.gz && \
    mv "/app/`ls /app`" /app/clion

RUN apt update && \
    wget https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init -O rustup-init && \
    chmod +x rustup-init

USER andrei

RUN ./rustup-init -y

COPY .bashrc .bashrc

RUN /home/andrei/.cargo/bin/rustup component add rust-analysis --toolchain stable-x86_64-unknown-linux-gnu && \
    /home/andrei/.cargo/bin/rustup component add rust-src --toolchain stable-x86_64-unknown-linux-gnu && \
    /home/andrei/.cargo/bin/rustup component add rls --toolchain stable-x86_64-unknown-linux-gnu

CMD ["/bin/bash", "--login", "/app/clion/bin/clion.sh"]
