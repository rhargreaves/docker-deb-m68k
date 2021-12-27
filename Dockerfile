FROM debian:bullseye AS buildstage
RUN apt-get update && apt-get install -y wget flex bison gperf zlib1g-dev sudo build-essential

RUN mkdir -p /tmp/m68k
COPY build_toolchain /tmp/m68k/
RUN cd /tmp/m68k && ./build_toolchain

# Second stage, just create the m68k user and copy the built files
FROM debian:bullseye
COPY --from=buildstage /tmp/m68k/staging/usr/ /usr/
RUN useradd -ms /bin/bash -d /m68k m68k

USER m68k
WORKDIR /m68k
ENTRYPOINT /bin/bash
