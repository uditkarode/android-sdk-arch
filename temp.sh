/opt/android-sdk/cmdline-tools/tools/bin/sdkmanager --install "ndk;21.0.6113669" "cmake;3.10.2.4988404" || true
cd /tmp
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
git clone https://github.com/uditkarode/AbleMusicPlayer
cd AbleMusicPlayer
./gradlew assembleDebug
cd ..
rm -rf AbleMusicPlayer
