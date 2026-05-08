@echo off
setlocal enabledelayedexpansion

:: 获取当前文件夹的名字
for %%I in ("%cd%") do set "folderName=%%~nxI"

:: 生成树状结构图
:: /f 表示包含文件名
:: /a 表示使用文本字符（防止在某些编辑器下显示乱码）
tree /f /a > "%folderName%.txt"

echo 结构已保存到文件: %folderName%.txt
pause
