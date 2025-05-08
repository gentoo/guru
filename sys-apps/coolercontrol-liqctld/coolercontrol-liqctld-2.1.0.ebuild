# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )
inherit distutils-r1 systemd

DESCRIPTION="Monitor and control your cooling and other devices (liqctld)"
HOMEPAGE="https://gitlab.com/coolercontrol/coolercontrol"
SRC_URI="
	https://gitlab.com/coolercontrol/coolercontrol/-/archive/${PV}/coolercontrol-${PV}.tar.bz2
"
S="${WORKDIR}/coolercontrol-${PV}/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-misc/liquidctl[${PYTHON_USEDEP}]
	dev-python/fastapi[${PYTHON_USEDEP}]
	dev-python/setproctitle[${PYTHON_USEDEP}]
	dev-python/uvicorn[${PYTHON_USEDEP}]
"

src_prepare() {
	pushd .. >/dev/null || die
	default
	popd >/dev/null || die
}

python_install_all() {
	doinitd ../packaging/openrc/init.d/coolercontrol-liqctld
	doconfd ../packaging/openrc/conf.d/coolercontrol-liqctld

	systemd_dounit ../packaging/systemd/coolercontrol-liqctld.service
}
