FROM buildpack-deps:bullseye

WORKDIR /kernel

RUN set -x \
    && apt update \
    && apt install -y \
        bc \
        build-essential \
        cpio \
        curl \
        git \
        gpg \
        kmod \
        python \
        rsync \
    && git config --global user.email "you@example.com" \
    && git config --global user.name "Your Name"

RUN set -x \
    && curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo \
    && chmod a+rx /bin/repo

RUN set -x \
    && echo "" | repo init -u https://android.googlesource.com/kernel/manifest -b android-gs-raviole-5.10-android12-qpr1-d \
    && repo sync

RUN set -x \
    && echo "CONFIG_NETFILTER_XT_TARGET_HL=m" >> build/build.config
    # && echo "CONFIG_NETFILTER_XT_TARGET_HMARK=m" >> build/build.config \
    # && echo "CONFIG_NET_ACT_PEDIT=m" >> build/build.config \
    # && echo "CONFIG_WIREGUARD=m" >> build/build.config

CMD ["/bin/bash", "-c", "KMI_SYMBOL_LIST_STRICT_MODE=0 build/build.sh; while :; do sleep 5 ; done"]

# docker cp container_name:/kernel/out/android-gs-pixel-5.10/dist/xt_HL.ko .
