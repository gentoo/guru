# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit linux-mod-r1 git-r3 distutils-r1 desktop systemd

EGIT_REPO_URI="https://github.com/johnfanv2/LenovoLegionLinux.git"

DESCRIPTION="Lenovo Legion Linux kernel module"
HOMEPAGE="https://github.com/johnfanv2/LenovoLegionLinux"

RDEPEND="sys-kernel/linux-headers
	sys-apps/lm-sensors
	sys-apps/dmidecode
	legion-tools? ( dev-python/PyQt5 dev-python/pyyaml dev-python/argcomplete )
	legion-acpi? ( sys-power/acpid )
	radeon-dgpu? ( dev-util/rocm-smi )
	downgrade-nvidia? ( <=x11-drivers/nvidia-drivers-525 )
	ryzenadj? ( sys-power/RyzenAdj )
	undervolt-intel? ( dev-python/undervolt )
"

DEPEND="${RDEPEND}"

LICENSE="GPL-2"
SLOT="0"
IUSE="legion-tools legion-acpi systemd radeon-dgpu downgrade-nvidia ryzenadj undervolt-intel"
REQUIRED_USE="|| ( systemd legion-acpi radeon-dgpu downgrade-nvidia ryzenadj legion-tools undervolt-intel ) legion-acpi? ( legion-tools ) radeon-dgpu? ( !downgrade-nvidia legion-tools ) downgrade-nvidia? ( !radeon-dgpu legion-tools ) undervolt-intel? ( !ryzenadj legion-tools ) ryzenadj? ( !undervolt-intel legion-tools )"

MODULES_KERNEL_MIN=5.10

src_compile() {
	local modlist=(
		legion-laptop=kernel/drivers/platform/x86:kernel_module:kernel_module:all
	)
	KERNELVERSION=${KV_FULL} linux-mod-r1_src_compile
	if use legion-tools; then
		#Define build dir (fix sandboxed)
		cd "${WORKDIR}/${P}/python/legion_linux"
		distutils-r1_src_compile --build-dir "${WORKDIR}/${P}/python/legion_linux/build"
	fi
}

src_install() {
	linux-mod-r1_src_install
	#Load the module without reboot
	pushd python/legion_linux/ || die
		make forcereloadmodule
	popd || die
	if use legion-tools; then
		#Define build dir (fix sandboxed)
		cd "${WORKDIR}/${P}/python/legion_linux/"
		distutils-r1_src_install --build-dir "${WORKDIR}/${P}/python/legion_linux/build"

		cd "${WORKDIR}/${P}/extra"

		if use legion-acpi; then
			insinto /etc/acpi/events/ && doins acpi/events/{ac_adapter_legion-fancurve,novo-button,PrtSc-button,fn-r-refrate}
			insinto /etc/acpi/actions/ && doins acpi/actions/{battery-legion-quiet.sh,snipping-tool.sh,fn-r-refresh-rate.sh}
		fi

		if use systemd; then
			systemd_dounit service/legion-linux.service service/legion-linux.path
			dobin service/fancurve-set
			insinto /usr/share/legion_linux && doins service/profiles/*
			insinto /etc/legion_linux && doins service/profiles/*

			#AMD
			if use radeon-dgpu; then
				insinto /usr/share/legion_linux && newins "${FILESDIR}/radeon" .env
				insinto /etc/legion_linux && newins "${FILESDIR}/radeon" .env
			fi
			#NVIDIA (need dowgrade because nvidia-smi -pl was removed)
			if use downgrade-nvidia; then 
				insinto /usr/share/legion_linux && newins "${FILESDIR}/nvidia" .env
				insinto /etc/legion_linux && newins "${FILESDIR}/nvidia" .env
			fi

			if use ryzenadj; then 
				insinto /usr/share/legion_linux && newins "${FILESDIR}/cpu" .env
				insinto /etc/legion_linux && newins "${FILESDIR}/cpu" .env
			fi
		fi

		# Desktop Files and Polkit
		domenu "${FILESDIR}/legion_gui.desktop"
		doicon "${WORKDIR}/${P}/python/legion_linux/legion_linux/legion_logo.png"
		insinto "/usr/share/polkit-1/actions/" && doins "${FILESDIR}/legion_cli.policy"

	fi
}

pkg_postinst() {
	if use systemd; then
		ewarn "Default config files are present in /usr/share/legion_linux"
		ewarn "Pls copy that folder to /etc/legion_linux and edit the fancurves to your liking"
		ewarn "Note:can be done using the gui app"
		ewarn "Dont forget to edit /etc/legion_linux/.env to enable and disable extra features"
		ewarn "Note the CPU and APU control command both for undervolt an ryzenadj are edit in /etc/legion_linux/.env command"
		ewarn "Note: use flag downgrade-nvidia in need for nvidia TDP control\n"
	fi
	ewarn "Note for 2023-2023 Legion user: It need help for testing the features"
	ewarn "Pls test the feature how is decribe in the README of the project!"
	ewarn "and also go to this issue in github: https://github.com/johnfanv2/LenovoLegionLinux/issues/46"

}
