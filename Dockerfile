FROM buildpack-deps:bullseye

WORKDIR /kernel

RUN set -x \
    && apt update \
    && apt install -y \
        build-essential \
        curl \
        git \
        gpg \
        python \
    && git config --global user.email "you@example.com" \
    && git config --global user.name "Your Name"

RUN set -x \
    && curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo \
    && chmod a+rx /bin/repo

RUN set -x \
    && "" | repo init -u https://android.googlesource.com/kernel/manifest -b android-msm-crosshatch-4.9-android12 \
    && repo sync

# RUN set -x \
#     && echo "CONFIG_NETFILTER_XT_TARGET_HL=m" >> build/build.config \
#     && echo "CONFIG_NETFILTER_XT_TARGET_HMARK=m" >> build/build.config

RUN set -x \
    && build/build.sh
