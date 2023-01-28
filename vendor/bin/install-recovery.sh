#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71102464:bb303d962f1c45e852e3f7588bc193eec3db83e6; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):61865984:9c4861a31f838e1fd58c2f37f3783d3e1d29df45 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71102464:bb303d962f1c45e852e3f7588bc193eec3db83e6 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

