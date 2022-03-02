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

# apt install -y clang
# export CROSS_COMPILE=$(pwd)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin
# export ARCH=arm64 && export SUBARCH=arm64
# make -j$(nproc --all) O=out \
#                       ARCH=arm64 \
#                       CC=clang \
#                       CLANG_TRIPLE=aarch64-linux-gnu- \
#                       CROSS_COMPILE=aarch64-linux-android- \
#                       CROSS_COMPILE_ARM32=arm-linux-androideabi-
RUN set -x \
    && echo "CONFIG_NETFILTER_XT_TARGET_HL=m" >> build/build.config \
    && echo "CONFIG_NETFILTER_XT_TARGET_HMARK=m" >> build/build.config

RUN set -x \
    && build/build.sh -j2 V=1
