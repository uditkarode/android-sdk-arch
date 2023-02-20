FROM archlinux:base-devel
ENV LANG=en_US.UTF-8

COPY depinstall.sh /tmp/
RUN bash /tmp/depinstall.sh

# download and install Gradle
# https://services.gradle.org/distributions/
ARG GRADLE_VERSION=7.6
ARG GRADLE_DIST=all
RUN cd /opt && \
    wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-${GRADLE_DIST}.zip && \
    unzip -qq gradle*.zip && \
    ls -d */ | sed 's/\/*$//g' | xargs -I{} mv {} gradle && \
    rm gradle*.zip

ENV PATH="/opt/gradle/bin:$PATH"

# download and install Kotlin
# https://github.com/JetBrains/kotlin/releases/latest
ARG KOTLIN_VERSION=1.8.10
RUN cd /opt && \
    wget -q https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip && \
    unzip -qq *kotlin*.zip && \
    rm *kotlin*.zip

ENV PATH="/opt/kotlinc/bin:$PATH"

# download and install Android SDK
# https://developer.android.com/studio#command-tools
ARG ANDROID_SDK_VERSION=9477386
ENV ANDROID_HOME /opt/android-sdk
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip && \
    unzip -qq *tools*linux*.zip -d ${ANDROID_HOME}/cmdline-tools && \
    rm *tools*linux*.zip

ENV PATH="/opt/android-sdk/cmdline-tools/cmdline-tools/bin:$PATH"
ENV PATH="/usr/lib/jvm/java-19-openjdk/bin:$PATH"

RUN echo '\
        . /etc/profile ; \
    ' >> /root/.profile

# install sdk and ndk
RUN sdkmanager --install "ndk;23.1.7779620" "cmake;3.6.4111459" "platforms;android-33" "build-tools;33.0.0" "platform-tools"

# accept the license agreements of the SDK components
RUN yes | sdkmanager --licenses
