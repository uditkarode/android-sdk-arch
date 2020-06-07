# just a test
# REMOVEME
sdkmanager --install "ndk;21.0.6113669" "cmake;21.0.6113669" || true
cd /tmp
git clone https://github.com/uditkarode/AbleMusicPlayer
cd AbleMusicPlayer
./gradlew assembleDebug
cd ..
rm -rf AbleMusicPlayer
