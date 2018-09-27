sf probe
mtdparts

sf read ${kernel_addr_r} kernel 0x00400000
sf read ${fdt_addr_r} script 0x00020000

setenv rootargs "ubi.mtd=6 root=/dev/mtdblock5 rootfstype=squashfs ro rootwait init=/preinit"

#setenv consargs "ignore_loglevel console=ttyS0,115200 console=tty1"
setenv consargs "ignore_loglevel console=ttyS0,115200"

setenv bootargs "${mtdparts} ${rootargs} ${consargs} cgroup_enable=memory swapaccount=1 hdmi.audio=EDID:0 disp.screen0_output_mode=1280x720p60 consoleblank=0 enforcing=0 sunxi_ve_mem_reserve=0 sunxi_g2d_mem_reserve=0 sunxi_fb_mem_reserve=16 fbcon=font:10x18"

setenv machid 1029
setenv bootm_boot_mode sec
setenv verbosity 1

bootz ${kernel_addr_r} -
#bootz ${kernel_addr_r} ${ramdisk_addr_r}

# Recompile with:
# mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
