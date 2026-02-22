FDEVICE="m14x"

fox_get_target_device() {
  local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
  if [ -n "$chkdev" ]; then
    FOX_BUILD_DEVICE="$FDEVICE"
  else
    chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
    [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
  fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
  fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

  # Version & Variant
  export FOX_BUILD_TYPE=Stable
  export FOX_MAINTAINER_PATCH_VERSION=1
  export USE_CCACHE="1"
  export TARGET_ARCH="arm64"
  export FOX_VANILLA_BUILD="1"
  export OF_MAINTAINER="PrismaDroid"
  export LC_ALL="C"
  export FOX_VANILLA_BUILD=1
  export FOX_VENDOR_BOOT_RECOVERY=0
  export FOX_NO_SAMSUNG_SPECIAL=0
  export FOX_INSTALLER_VENDOR_BOOT_RAMDISK_INSTALL=0
  export OF_FLASHLIGHT_ENABLE=1
  export FOX_DELETE_AROMAFM=1
  export FOX_USE_UPDATED_MAGISKBOOT=1

  # OrangeFox Addons
  #export FOX_ENABLE_APP_MANAGER=1

  # General
  export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
  export FOX_USE_BASH_SHELL=1
  export FOX_ASH_IS_BASH=1
  export FOX_USE_NANO_EDITOR=1
  #unset FOX_REPLACE_BUSYBOX_PS

  # OrangeFox Device Properties
  export FOX_VIRTUAL_AB_DEVICE=0

  # Binaries & Tools
  export FOX_REPLACE_TOOLBOX_GETPROP=1
  export FOX_USE_BASH_SHELL=1
  export FOX_ASH_IS_BASH=1
  export FOX_USE_NANO_EDITOR=1
  export FOX_USE_TAR_BINARY=1
  export FOX_USE_SED_BINARY=1
  export FOX_USE_XZ_UTILS=1

  # Compression & Binary
  #  export OF_USE_LZ4_COMPRESSION=1
  #  export FOX_USE_LZ4_BINARY=1
  #  export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1

  lunch twrp_$FDEVICE-eng
  # let's see what are our build VARs
  if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
    export | grep "FOX" >>$FOX_BUILD_LOG_FILE
    export | grep "OF_" >>$FOX_BUILD_LOG_FILE
    export | grep "TW_" >>$FOX_BUILD_LOG_FILE
    export | grep "TARGET_" >>$FOX_BUILD_LOG_FILE
  fi
fi
