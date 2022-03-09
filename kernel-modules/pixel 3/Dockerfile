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
    && git config --global user.email "you@example.com" \
    && git config --global user.name "Your Name"

RUN set -x \
    && curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo \
    && chmod a+rx /bin/repo

RUN set -x \
    && echo "" | repo init -u https://android.googlesource.com/kernel/manifest -b android-msm-crosshatch-4.9-android12 \
    && repo sync

RUN set -x \
    && echo "CONFIG_NETFILTER_XT_TARGET_HL=m" >> build/build.config
    # && echo "CONFIG_NETFILTER_XT_TARGET_HMARK=m" >> build/build.config \
    # && echo "CONFIG_NET_ACT_PEDIT=m" >> build/build.config
    # pedit is used for tc

# RUN set -x \
#     && build/build.sh -j2 V=1 EXT_MODULES="wireguard"
CMD ["/bin/bash", "-c", "build/build.sh"]
