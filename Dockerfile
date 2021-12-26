From debian:bullseye

RUN apt-get update && apt-get install -y wget flex bison gperf zlib1g-dev sudo build-essential

RUN useradd -ms /bin/bash -d /m68k m68k -G sudo
# Do not require password for sudo
RUN sed -i 's/%sudo	ALL=(ALL:ALL) ALL/%sudo ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

USER m68k
WORKDIR /m68k

COPY build_toolchain /m68k/
RUN cd /m68k && ./build_toolchain
# Clean build files
RUN rm /m68k/* -rf

ENTRYPOINT /bin/bash
