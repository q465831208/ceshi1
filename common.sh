#!/bin/bash
# https://github.com/281677160/build-openwrt
# common Module by 28677160
# matrix.target=${Modelfile}

# 全脚本源码通用diy.sh文件
Diy_all() {
git clone -b $REPO_BRANCH --single-branch https://github.com/281677160/openwrt-package package/danshui
git clone https://github.com/281677160/luci-app-autoupdate package/luci-app-autoupdate
mv common/{AutoUpdate.sh,AutoBuild_Tools.sh} package/base-files/files/bin
chmod -R +x package/base-files/files/bin
}

# 全脚本源码通用diy2.sh文件
Diy_all2() {
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd
rm -rf {LICENSE,README,README.md}
rm -rf ./*/{LICENSE,README,README.md}
rm -rf ./*/*/{LICENSE,README,README.md}
}

################################################################################################################
# LEDE源码通用diy1.sh文件
################################################################################################################
Diy_lede() {
cp -Rf common/LEDE/* "${PATH1}"
rm -rf package/lean/v2ray-plugin
rm -rf package/lean/{luci-app-netdata,luci-theme-argon,k3screenctrl}
sed -i 's/iptables -t nat/# iptables -t nat/g' package/lean/default-settings/files/zzz-default-settings
if [[ "${Modelfile}" == "Lede_x86_64" ]]; then
sed -i '/IMAGES_GZIP/d' "${PATH1}/${CONFIG_FILE}" > /dev/null 2>&1
echo -e "\nCONFIG_TARGET_IMAGES_GZIP=y" >> "${PATH1}/${CONFIG_FILE}"
fi
sed -i '$i '"chmod -R +x /etc/init.d/AdGuardHome /usr/share/AdGuardHome/addhost.sh"'' ./package/lean/default-settings/files/zzz-default-settings
git clone https://github.com/fw876/helloworld package/danshui/luci-app-ssr-plus
git clone https://github.com/xiaorouji/openwrt-passwall package/danshui/luci-app-passwall
git clone https://github.com/jerrykuku/luci-app-vssr package/danshui/luci-app-vssr
git clone https://github.com/vernesong/OpenClash package/danshui/luci-app-openclash
#git clone https://github.com/frainzy1477/luci-app-clash package/danshui/luci-app-clash
git clone https://github.com/garypang13/luci-app-bypass package/danshui/luci-app-bypass
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
}
################################################################################################################
# LEDE源码通用diy2.sh文件
################################################################################################################
Diy_lede2() {
echo
}

################################################################################################################


################################################################################################################
# LIENOL源码通用diy1.sh文件
################################################################################################################
Diy_lienol() {
cp -Rf build/common/LIENOL/* "${PATH1}"
rm -rf package/lean/{luci-app-netdata,luci-theme-argon,k3screenctrl}
git clone https://github.com/fw876/helloworld package/danshui/luci-app-ssr-plus
git clone https://github.com/xiaorouji/openwrt-passwall package/danshui/luci-app-passwall
git clone https://github.com/jerrykuku/luci-app-vssr package/danshui/luci-app-vssr
git clone https://github.com/vernesong/OpenClash package/danshui/luci-app-openclash
git clone https://github.com/frainzy1477/luci-app-clash package/danshui/luci-app-clash
git clone https://github.com/garypang13/luci-app-bypass package/danshui/luci-app-bypass
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
}
################################################################################################################
# LIENOL源码通用diy2.sh文件
################################################################################################################
Diy_lienol2() {
echo
sed -i 's/"免费开源，功能强大的全网络广告和跟踪程序拦截DNS服务器"/"免费去广告和跟踪程序拦截DNS服务器，网页管理账号和密码均为：admin"/g' package/diy/luci-app-adguardhome/po/zh-cn/AdGuardHome.po
sed -i '$i '"chmod -R +x /etc/init.d/AdGuardHome /usr/share/AdGuardHome/addhost.sh"'' ./package/default-settings/files/zzz-default-settings
}

################################################################################################################


################################################################################################################
# 天灵源码通用diy1.sh文件
################################################################################################################
Diy_immortalwrt() {
cp -Rf build/common/PROJECT/* "${PATH1}"
rm -rf package/lienol/luci-app-timecontrol
rm -rf package/ctcgfw/{luci-app-argon-config,luci-theme-argonv3,luci-app-adguardhome}
rm -rf package/lean/luci-theme-argon
if [ -n "$(ls -A "${PATH1}/patches/1806-modify_for_r4s.patch" 2>/dev/null)" ]; then
curl -fsSL https://raw.githubusercontent.com/1715173329/nanopi-r4s-openwrt/master/patches/1806-modify_for_r4s.patch > "${PATH1}/patches"/1806-modify_for_r4s.patch
fi
if [ -n "$(ls -A "${PATH1}/patches/1806-modify_for_r2s.patch" 2>/dev/null)" ]; then
curl -fsSL https://raw.githubusercontent.com/1715173329/nanopi-r2s-openwrt/master/patches/1806-modify_for_r2s.patch > "${PATH1}/patches"/1806-modify_for_r2s.patch
fi
git clone https://github.com/garypang13/luci-app-bypass package/danshui/luci-app-bypass

}

################################################################################################################
# 天灵源码通用diy2.sh文件
################################################################################################################
Diy_immortalwrt2() {
echo
rm -rf feeds/packages/net/adguardhome
sed -i '$i '"chmod -R +x /etc/init.d/AdGuardHome /usr/share/AdGuardHome/addhost.sh"'' ./package/lean/default-settings/files/zzz-default-settings
}

################################################################################################################

################################################################################################################
# 判断脚本是否缺少主要文件（如果缺少settings.ini设置文件在检测脚本设置就运行错误了）

Diy_settings() {
rm -rf ${Home}/build/QUEWENJIANerros
if [ -n "$(ls -A "$PATH1/${CONFIG_FILE}" 2>/dev/null)" ]; then
	echo
else
	echo ""
	echo "编译脚本缺少[${CONFIG_FILE}]配置文件,请在[build/${Modelfile}]文件夹补齐"
	echo "errors" > build/QUEWENJIANerros
fi
if [ -n "$(ls -A "$PATH1/${DIY_P1_SH}" 2>/dev/null)" ]; then
	echo
else
	echo "编译脚本缺少[${DIY_P1_SH}]配置文件,请在[build/${Modelfile}]文件夹补齐"
	echo "errors" > build/QUEWENJIANerros
fi
if [ -n "$(ls -A "$PATH1/${DIY_P2_SH}" 2>/dev/null)" ]; then
	echo
else
	echo "编译脚本缺少[${DIY_P2_SH}]配置文件,请在[build/${Modelfile}]文件夹补齐"
	echo "errors" > build/QUEWENJIANerros
fi
if [ -n "$(ls -A "${Home}/build/QUEWENJIANerros" 2>/dev/null)" ]; then
rm -rf ${Home}/build/QUEWENJIANerros
exit 1
fi
}



################################################################################################################
# 判断AdGuard Home

Diy_adgu() {
if [ `grep -c "CONFIG_TARGET_x86_64=y" ${Home}/.config` -eq '1' ]; then
	TARGET_ADG="x86-64"
else
	TARGET_ADG="$(egrep -o "CONFIG_TARGET.*DEVICE.*=y" .config | sed -r 's/.*DEVICE_(.*)=y/\1/')"
fi
if [[ "${TARGET_ADG}" == "x86-64" ]];then
	if [ `grep -c "CONFIG_PACKAGE_luci-app-adguardhome=y" ${Home}/.config` -eq '1' ]; then
		svn co https://github.com/281677160/ceshi1/branches/AdGuard/x86-64 ${Home}/files
		chmod -R +x ${Home}/files
	fi
fi
if [[ "${TARGET_ADG}" == "friendlyarm_nanopi-r2s" ]];then
	if [ `grep -c "CONFIG_PACKAGE_luci-app-adguardhome=y" ${Home}/.config` -eq '1' ]; then
		svn co https://github.com/281677160/ceshi1/branches/AdGuard/R2S ${Home}/files
		chmod -R +x ${Home}/files
	fi
fi

if [ `grep -c "CONFIG_PACKAGE_luci-app-adguardhome=y" ${Home}/.config` -eq '1' ]; then
	if [ -n "$(ls -A "${Home}/files/etc/config/AdGuardHome.yaml" 2>/dev/null)" ]; then
		echo
	else
		svn co https://github.com/281677160/ceshi1/branches/AdGuard/peizhi ${Home}/files/etc/config
		chmod -R +x ${Home}/files
	fi
fi
}
################################################################################################################
# N1、微加云、贝壳云、我家云、S9xxx 打包程序

Diy_n1() {
cd ../
svn co https://github.com/281677160/N1/trunk reform
cp openwrt/bin/targets/armvirt/*/*.tar.gz reform/openwrt
cd reform
sudo ./gen_openwrt -d -k latest
         
devices=("phicomm-n1" "rk3328" "s9xxx" "vplus")
}

################################################################################################################


################################################################################################################
# 公告

Diy_notice() {
echo ""
echo "	《公告内容》"
echo " 祝大家天天快乐、生活愉快！"
echo " 使用中有疑问的可以加入电报群，跟群友交流"
echo "[Telegram交流群] https://t.me/joinchat/AAAAAE3eOMwEHysw9HMcVQ"
echo ""
}
################################################################################################################


################################################################################################################
# 编译信息

Diy_xinxi_Base() {
GET_TARGET_INFO
if [[ "${TARGET_PROFILE}" =~ (x86-64|phicomm-k3|d-team_newifi-d2|phicomm_k2p|k2p|phicomm_k2p-32m) ]]; then
	Firmware_mz="${TARGET_PROFILE}自动适配"
	Firmware_hz="${TARGET_PROFILE}自动适配"
else
	Firmware_mz="${Up_Firmware}"
	Firmware_hz="${Firmware_sfx}"
fi
if [[ "${Modelfile}" =~ (Lede_phicomm_n1|Project_phicomm_n1) ]]; then
	TARGET_PROFILE="N1,Vplus,Beikeyun,L1Pro,S9xxx"
fi
echo ""
echo " 编译源码: ${COMP2}"
echo " 源码链接: ${REPO_URL}"
echo " 源码分支: ${REPO_BRANCH}"
echo " 源码作者: ${ZUOZHE}"
echo " 编译机型: ${TARGET_PROFILE}"
echo " 固件作者: ${Author}"
echo " 仓库地址: ${Github_Repo}"
if [[ ${UPLOAD_BIN_DIR} == "true" ]]; then
	echo " 上传BIN文件夹(固件+IPK): 开启"
else
	echo " 上传BIN文件夹(固件+IPK): 关闭"
fi
if [[ ${UPLOAD_CONFIG} == "true" ]]; then
	echo " 上传[.config]配置文件: 开启"
else
	echo " 上传[.config]配置文件: 关闭"
fi
if [[ ${UPLOAD_FIRMWARE} == "true" ]]; then
	echo " 上传固件在github actions: 开启"
else
	echo " 上传固件在github actions: 关闭"
fi
if [[ ${UPLOAD_COWTRANSFER} == "true" ]]; then
	echo " 上传固件到到【奶牛快传】和【WETRANSFER】: 开启"
else
	echo " 上传固件到到【奶牛快传】和【WETRANSFER】: 关闭"
fi
if [[ ${UPLOAD_RELEASE} == "true" ]]; then
	echo " 发布固件: 开启"
else
	echo " 发布固件: 关闭"
fi
if [[ ${SERVERCHAN_SCKEY} == "true" ]]; then
	echo " 微信/电报通知: 开启"
else
	echo " 微信/电报通知: 关闭"
fi
if [[ ${SSH_ACTIONS} == "true" ]]; then
	echo " SSH远程连接: 开启"
else
	echo " SSH远程连接: 关闭"
fi
if [[ ${SSHYC} == "true" ]]; then
	echo " SSH远程连接临时开关: 开启"
fi
if [[ ${REGULAR_UPDATE} == "true" ]]; then
	echo ""
	echo " 把定时自动更新插件编译进固件: 开启"
	echo " 插件版本: ${AutoUpdate_Version}"
	echo " 固件名称: ${Firmware_mz}"
	echo " 固件后缀: ${Firmware_hz}"
	echo " 固件版本: ${Openwrt_Version}"
	echo " 云端路径: ${Github_UP_RELEASE}"
	echo " 《编译成功，会自动把固件发布到指定地址，然后才会生成云端路径》"
	echo " 《请把“REPO_TOKEN”密匙设置好,没设置好密匙不能发布就生成不了云端地址》"
	echo " 《x86-64、phicomm_k2p、phicomm-k3、newifi-d2已自动适配固件名字跟后缀，无需自行设置》"
	echo " 《如有其他机子可以用定时更新固件的话，请告诉我，我把固件名字跟后缀适配了》"
	echo ""
else
	echo " 把定时自动更新插件编译进固件: 关闭"
	echo ""
fi
echo " * 您当前使用的是【${Modelfile}】文件夹编译【${TARGET_PROFILE}】固件,请核对以上信息是否正确！*"
echo ""
echo ""
echo " 系统空间      类型   总数  已用  可用 使用率"
cd ../ && df -hT $PWD && cd openwrt
}
