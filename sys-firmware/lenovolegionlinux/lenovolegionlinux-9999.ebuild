# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

M_PN=LenovoLegionLinux

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{9..12})

inherit linux-mod-r1 distutils-r1 systemd

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/johnfanv2/${M_PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/johnfanv2/${M_PN}/archive/refs/tags/v${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Lenovo Legion Linux kernel module"
HOMEPAGE="https://github.com/johnfanv2/LenovoLegionLinux"

BDEPEND="
	sys-kernel/linux-headers
	sys-apps/lm-sensors
	sys-apps/dmidecode
	sys-apps/sed
"

RDEPEND="
	gui? (
		dev-python/PyQt6[gui,widgets]
		dev-python/pyyaml
		dev-python/argcomplete
		dev-python/darkdetect
		sys-power/acpid
	)
	downgrade-nvidia? ( <=x11-drivers/nvidia-drivers-525 )
	radeon-dgpu? ( dev-util/rocm-smi )
	ryzenadj? ( sys-power/RyzenAdj )
	undervolt-intel? ( dev-python/undervolt )
"

DEPEND="${RDEPEND}"

LICENSE="GPL-2"
SLOT="0"
IUSE="+gui radeon-dgpu downgrade-nvidia ryzenadj undervolt-intel"
REQUIRED_USE="|| ( radeon-dgpu downgrade-nvidia ryzenadj gui undervolt-intel ) radeon-dgpu? ( !downgrade-nvidia gui ) downgrade-nvidia? ( !radeon-dgpu gui ) undervolt-intel? ( !ryzenadj gui ) ryzenadj? ( !undervolt-intel gui )"

MODULES_KERNEL_MIN=5.10

src_compile() {
	local modlist=(
		legion-laptop=kernel/drivers/platform/x86:kernel_module:kernel_module:all
	)
	export KERNELVERSION=${KV_FULL}
	linux-mod-r1_src_compile
	if use gui; then
		if [[ ${PV} == "9999" ]]; then
			#fix python package version
			sed -i "s/version = _VERSION/version = 9999/g" "${WORKDIR}/${P}/python/legion_linux/setup.cfg"
		else
			#fix python package version
			sed -i "s/version = _VERSION/version = ${PV}/g" "${WORKDIR}/${P}/python/legion_linux/setup.cfg"
		fi
		#Define build dir (fix sandboxed)
		cd "${WORKDIR}/${P}/python/legion_linux" || die
		distutils-r1_src_compile --build-dir "${WORKDIR}/${P}/python/legion_linux/build"
		cd "legion_linux/extra/service/legiond" || die
		emake
	fi
}

src_install() {
	linux-mod-r1_src_install
	if use gui; then
		#Define build dir (fix sandboxed)
		cd "${WORKDIR}/${P}/python/legion_linux/" || die
		distutils-r1_src_install --build-dir "${WORKDIR}/${P}/python/legion_linux/build"

		cd "${WORKDIR}/${P}/extra" || die

		systemd_dounit service/legiond.service service/legiond-onresume.service
		insinto /etc/acpi/events
		doins acpi/events/{legion_ppd,legion_ac}
		dobin service/legiond/legiond
		dobin service/legiond/legiond-cli
	fi
}

pkg_postinst() {
	ewarn "Default config files are present in /usr/share/legion_linux"
	ewarn "Copy folder /usr/share/legion_linux to /etc/legion_linux"
	ewarn "Note: Fancurve can be edit using the gui app"
	ewarn "Dont forget to edit /etc/legion_linux/.env to enable and disable extra features"
	ewarn "Note the CPU and APU control command both for undervolt an ryzenadj are edit in /etc/legion_linux/.env"
	if !use downgrade-nvidia; then
		ewarn "Note: use flag downgrade-nvidia if you need for nvidia TDP control (requires driver 525 to work)\n"
		ewarn "This useflag will be drop soon since 525 is almost 6 months old"
	else
		ewarn "Note: Edit /etc/legion_linux/.env to enable nvidia TDP control\n"
	fi
	ewarn "Note for 2023-2023 Legion user: It need help for testing the features"
	ewarn "Pls test the feature how is decribe in the README of the project!"
	ewarn "and also go to this issue in github: https://github.com/johnfanv2/LenovoLegionLinux/issues/46"
}
