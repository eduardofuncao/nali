function emulator
  mkdir -p ~/.android/avd

  set -l sdk (dirname (dirname (readlink -f (which sdkmanager))))/libexec/android-sdk
  if not test -d $sdk/emulator
    echo "ERROR: Android SDK not found. Rebuild first."
    return 1
  end

  set -l avd test-device

  if not test -f ~/.android/avd/$avd.avd/config.ini
    echo "No" | ANDROID_SDK_ROOT=$sdk avdmanager create avd \
      -n $avd \
      -k "system-images;android-35;google_apis;x86_64" \
      -d "pixel_6"
  end

  QT_QPA_PLATFORM=xcb \
  LIBGL_DRI3_DISABLE=1 \
  ANDROID_SDK_ROOT=$sdk \
  ANDROID_AVD_HOME=~/.android/avd \
  $sdk/emulator/emulator \
    -avd $avd \
    -gpu host \
    -accel on \
    -memory 4096 \
    -cores 4 \
    -no-metrics \
    -qemu -device virtio-keyboard-pci
end
