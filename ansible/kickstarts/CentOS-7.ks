#platform=x86, AMD64, or Intel EM64T
#version=DEVEL
# Firewall configuration
firewall --disabled
# Install OS instead of upgrade
install
# Use HTTP installation media
url --url="http://10.0.0.1/cblr/links/CentOS-7-x86_64/"

# Root password
rootpw --iscrypted $1$NMR6KnIz$4shkHhf.CU1/4ZVRfflwz1

# Network information
network --bootproto=dhcp --device=eth0 --onboot=on

# Reboot after installation
reboot

# System authorization information
auth useshadow passalgo=sha512

# Use graphical install
graphical

firstboot disable

# System keyboard
keyboard us

# System language
lang en_US

# SELinux configuration
selinux disabled

# Installation logging level
logging level=info

# System timezone
timezone Europe/Amsterdam

# System bootloader configuration
bootloader location=mbr

clearpart --all --initlabel
part swap --asprimary --fstype="swap" --size=1024
part /boot --fstype xfs --size=500
part pv.01 --size=1 --grow
volgroup root_vg01 pv.01
logvol / --fstype xfs --name=lv_01 --vgname=root_vg01 --size=1 --grow

%packages --ignoremissing
@^minimal
@base
vim
epel-release
wget
curl
net-tools

@core
%end
%post SNIPPET::publickey_root $kickstart_done
%end
%addon com_redhat_kdump --disable --reserve-mb='auto'
%end
