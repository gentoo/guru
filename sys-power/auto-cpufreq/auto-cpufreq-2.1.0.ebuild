# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_PEP517=poetry

inherit distutils-r1 systemd

DESCRIPTION="Automatic CPU speed & power optimizer for Linux"
HOMEPAGE="https://github.com/AdnanHodzic/auto-cpufreq"
SRC_URI="https://github.com/AdnanHodzic/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"
IUSE="systemd"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

DOCS=( README.md )
PATCHES=( "${FILESDIR}/${PN}-remove-poetry_versioning.patch" )

src_prepare() {
	sed -i 's|usr/local|usr|g' "scripts/${PN}.service" "scripts/${PN}-openrc" auto_cpufreq/core.py || die
	distutils-r1_src_prepare
}

python_install() {
	distutils-r1_python_install

	exeinto "/usr/share/${PN}/scripts"
	doexe scripts/cpufreqctl.sh

	if use systemd; then
		systemd_douserunit "scripts/${PN}.service"
	else
		doinitd "scripts/${PN}-openrc"
		mv "${D}/etc/init.d/${PN}-openrc" "${D}/etc/init.d/${PN}" || die
	fi
}

pkg_postinst() {
	touch /var/log/auto-cpufreq.log

	elog ""
	elog "Enable auto-cpufreq daemon service at boot:"
	if use systemd; then
		elog "systemctl enable --now auto-cpufreq"
	else
		elog "rc-update add auto-cpufreq default"
	fi
	elog ""
	elog "To view live log, run:"
	elog "auto-cpufreq --stats"
}

pkg_postrm() {
	# Remove auto-cpufreq log file
	if [ -f "/var/log/auto-cpufreq.log" ]; then
		rm /var/log/auto-cpufreq.log || die
	fi

	# Remove auto-cpufreq's cpufreqctl binary
	# it overwrites cpufreqctl.sh
	if [ -f "/usr/bin/cpufreqctl" ]; then
		rm /usr/bin/cpufreqctl || die
	fi

	# Restore original cpufreqctl binary if backup was made
	if [ -f "/usr/bin/cpufreqctl.auto-cpufreq.bak" ]; then
		mv /usr/bin/cpufreqctl.auto-cpufreq.bak /usr/bin/cpufreqctl || die
	fi
}
