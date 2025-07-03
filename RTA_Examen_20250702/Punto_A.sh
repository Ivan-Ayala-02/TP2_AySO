#!/bin/bash
clear
echo "Creo un particionamiento logico de 1.5GB para work-area"

# En un disco de 1GB uso todo el almacenamiento y le doy formato LVM
sudo fdisk /dev/sdc << FIN
n
p
1


t
8E
w
FIN

# En otro disco de 1GB uso el almacenamiento completo con formato LVM
sudo fdisk /dev/sdd << FIN
n
p
1


t
8E
w
FIN

# Ahora trabajo con el formato LVM y los agrupo
sudo pvcreate /dev/sdc1
sudo vgcreate vg_datos /dev/sdc1
sudo lvcreate -l +100%FREE  vg_datos -n lv_multimedia

# Le doy formato ext4
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_multimedia

# Creacion y montaje de volumen logico
sudo mkdir -p /multimedia
sudo mount /dev/mapper/vg_datos-lv_multimedia /multimedia

# Ahora extiendo el VG anterior con el disco restante
sudo pvcreate /dev/sdd1
sudo vgextend vg_datos /dev/sdd1
sudo lvextend -L +512MB /dev/mapper/vg_datos-lv_multimedia

# Redimensionar disco
sudo resize2fs /dev/mapper/vg_datos-lv_multimedia

echo "Creo un particionamiento lógico de 10MB para el uso de docker"

# Creo el LV, le doy formato y lo monto dentro de la carpeta
sudo lvcreate -L 10M vg_datos -n  lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker/

echo "Creo un particionamiento logico de 2GB para uso de memoria swap"

# En el disco de 3GB solo uso 2GB y le doy formato LVM
sudo fdisk /dev/sde << FIN
n
p
1

+2G
t
8E
w
FIN

# Creo un volumen logico de 2GB
sudo pvcreate /dev/sde1
sudo vgcreate vg_temp /dev/sde1
sudo lvcreate -l +100%FREE vg_temp -n lv_swap

# Preparo el LV como espacio de memoria SWAP
sudo mkswap /dev/mapper/vg_temp-lv_swap
sudo swapon /dev/mapper/vg_temp-lv_swap


echo "Creo un particionamiento clásico de 512MB para memoria SWAP"
sudo fdisk /dev/sde << FIN
n
p
2

+512M
t
2
82
w
FIN

# Formateo la particion y activo la memoria SWAP
sudo mkswap /dev/sde2
sudo swapon /dev/sde2
