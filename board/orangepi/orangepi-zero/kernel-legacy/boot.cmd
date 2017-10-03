sf probe
mtdparts
ubi part rootfs
ubifsmount ubi0:rootfs
ubifsload ${kernel_addr_r} /boot/zImage
#ubifsload ${ramdisk_addr_r} initrd
ubifsload ${fdt_addr_r} /boot/script.bin
ubifsumount
ubi detach

setenv rootargs "ubi.mtd=2 root=ubi0:rootfs rootfstype=ubifs rw rootwait"

#setenv consargs "ignore_loglevel console=ttyS0,115200 console=tty1"
setenv consargs "ignore_loglevel console=ttyS0,115200"

setenv bootargs "${mtdparts} ${rootargs} ${consargs} cgroup_enable=memory swapaccount=1 hdmi.audio=EDID:0 disp.screen0_output_mode=1920x1080p60 consoleblank=0 enforcing=0 sunxi_ve_mem_reserve=0 sunxi_g2d_mem_reserve=0 sunxi_fb_mem_reserve=16"

setenv machid 1029
setenv bootm_boot_mode sec
setenv verbosity 1

bootz ${kernel_addr_r} -
#bootz ${kernel_addr_r} ${ramdisk_addr_r}

# Recompile with:
# mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
