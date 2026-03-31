Error:

chown: invalid user: ‘lost+found:lost+found’

E: Sub-process /usr/bin/dpkg returned an error code (1)

Solution:

```
# 备份原脚本
sudo cp /var/lib/dpkg/info/parrot-core.postinst /var/lib/dpkg/info/parrot-core.postinst.bak
```

```
# 编辑脚本
sudo nano /var/lib/dpkg/info/parrot-core.postinst
```

找到上面那段 for user in $(cd /home; ls); do 的循环，在循环开头添加一个判断，跳过 lost+found 和可能存在的系统目录（如 .、.. 等）。修改后的代码示例：

```
for user in $(cd /home; ls); do
    # 跳过非用户目录
    [ "$user" = "lost+found" ] && continue
    [ "$user" = "." ] && continue
    [ "$user" = ".." ] && continue
    # 可选：只处理真实用户（检查 /etc/passwd 中是否存在该用户）
    if ! id "$user" &>/dev/null; then
        continue
    fi
    TEMP=$(mktemp -d) || exit 100
    rsync -a /etc/skel/ $TEMP/ || exit 101
    chown $user:$user -R $TEMP/ || exit 102
    if [ -n "$user" ]; then
        rsync -Pahv "$TEMP/" "/home/$user/" || exit 103
    fi
    rm -r $TEMP
done
```


```
sudo dpkg --configure parrot-core
```

```
sudo dpkg --configure -a
```

```
sudo dpkg --configure grub-pc
```

```
sudo dpkg --configure -a
```

```
# 清理无用的依赖包
sudo apt autoremove

# 再次运行系统升级
sudo parrot-upgrade
# 或
sudo apt update && sudo apt full-upgrade
```
