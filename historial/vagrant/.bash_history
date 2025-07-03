pwd
history -a
ll
vim .bash_history
sudo useradd -m -s /bin/bash -c "usuario examen segundo parcial" iayala
sudo usermod -aG sudo iayala
sudo usermod -aG docker iayala
echo 'iayala ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/iayala
vim  /etc/sudoers.d/iayala
sudo vim  /etc/sudoers.d/iayala
sudo su iayala
exit
lbslk
lsblk
umount /dev/mapper/vg_oracle-lv_oracle
umount /dev/mapper/vg_datos-lv_multimedia
lvremove /dev/mapper/vg_datos-lv_multimedia
sudo lvremove /dev/mapper/vg_datos-lv_multimedia
lbslk
lsblk
lvs
sudo lvs
sudo bgs
sudo vgs
vgremove vg_datos
sudo vgremove vg_datos
pvs
sudo pvs
sudo vgcreate vg_datos /dev/sdc1
sudo lvcreate -l +100%FREE  vg_datos -n lv_multimedia
sudo lvdisplay
sudo lvs
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_multimedia
lsblk
sudo mount /dev/mapper/vg_datos-lv_multimedia /multimedia
lsblk
sudo vgextend vg_datos /dev/sdd1
sudo vgs
sudo lvextend -L +512MB /dev/mapper/vg_datos-lv_multimedia
sudo resize2fs /dev/mapper/vg_datos-lv_multimedia
lbslk
lsblk
ll
cd
ll
sudo su iayala
cd
vim .bash_history 
