FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# ============================================================
# Versions
# ============================================================

ARG FLUTTER_VERSION=3.47.0
ARG ANDROID_CMDLINE_TOOLS_VERSION=11076708_latest

# ============================================================
# Environment
# ============================================================

ENV ANDROID_HOME=/opt/android-sdk
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV FLUTTER_HOME=/opt/flutter

ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/platform-tools/bin:${PATH}"

# ============================================================
# System dependencies
# ============================================================

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    file \
    git \
    libglu1-mesa \
    openjdk-17-jdk \
    unzip \
    wget \
    xz-utils \
    zip \
    && rm -rf /var/lib/apt/lists/*

# ============================================================
# Android Command Line Tools
# ============================================================

RUN mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && curl -fsSL \
    -o /tmp/cmdline-tools.zip \
    "https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_CMDLINE_TOOLS_VERSION}.zip" \
    && unzip -q /tmp/cmdline-tools.zip -d /tmp/cmdline-tools \
    && mv /tmp/cmdline-tools/cmdline-tools \
    ${ANDROID_HOME}/cmdline-tools/latest \
    && rm -rf /tmp/cmdline-tools /tmp/cmdline-tools.zip

# ============================================================
# Accept Android licenses
# ============================================================

RUN yes | sdkmanager --licenses > /dev/null

# ============================================================
# Android SDK
#
# Install common versions BEFORE Jenkins runs.
# ============================================================

RUN sdkmanager \
    "platform-tools" \
    "platforms;android-34" \
    "platforms;android-35" \
    "platforms;android-36" \
    "build-tools;34.0.0" \
    "build-tools;35.0.0" \
    "build-tools;36.0.0" \
    "ndk;28.2.13676358"

# ============================================================
# Flutter
# ============================================================

RUN git clone \
    --depth 1 \
    --branch ${FLUTTER_VERSION} \
    https://github.com/flutter/flutter.git \
    ${FLUTTER_HOME} \
    && git config --global --add safe.directory ${FLUTTER_HOME}

# ============================================================
# Flutter configuration
# ============================================================

RUN flutter config --android-sdk ${ANDROID_HOME} \
    && flutter config --no-analytics \
    && yes | flutter doctor --android-licenses > /dev/null

# ============================================================
# IMPORTANT:
# Download Android Flutter artifacts into the image.
#
# --force makes Flutter download the required artifacts again
# instead of relying on an incomplete cache.
# ============================================================

RUN flutter precache --android --force

# ============================================================
# Verify Flutter
# ============================================================

RUN flutter doctor -v

# ============================================================
# Verify important Android packages
# ============================================================

RUN sdkmanager --list_installed

# ============================================================
# Workspace
# ============================================================

WORKDIR /workspace

CMD ["bash"]