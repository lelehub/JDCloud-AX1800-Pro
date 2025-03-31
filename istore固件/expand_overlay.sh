#!/bin/bash

# 欢迎使用猫点饭提供的亚瑟软件包扩容脚本！如果您对路由器刷机和玩法感兴趣，欢迎关注我的公众号：猫点饭
# 检查是否为root用
if [ "$(id -u)" != "0" ]; then
   echo "此脚本必须以root身份运行" 1>&2
   exit 1
fi

# 定义分区和挂载点
PARTITION="/dev/mmcblk0p27"
MOUNT_POINT="/mnt/mmcblk0p27"

# 卸载分区
umount $PARTITION

# 格式化分区
mkfs.ext4 -F $PARTITION

# 挂载分区
mount $PARTITION $MOUNT_POINT

# 拷贝overlay分区文件
cp -r /overlay/* $MOUNT_POINT

# 检查拷贝是否成功
if [ -d "$MOUNT_POINT/upper" ]; then
    echo "拷贝成功"
else
    echo "拷贝失败，请检查"
    exit 1
fi

# 生成挂载文件
block detect > /etc/config/fstab

# 把p27分区挂载到overlay
sed -i s#/mnt/mmcblk0p27#/overlay# /etc/config/fstab

# 取消原overlay挂载
sed -i '12s/1/0/g' /etc/config/fstab

# 重启提示
echo "扩容操作已完成，感谢您使用本脚本，即将重启..."
echo "京东云亚瑟AX1800 Pro参数：https://mao.fan/Router/JD/AX1800Pro 了解更多路由器刷机技巧和玩法，请关注公众号：猫点饭"
sleep 3
reboot
