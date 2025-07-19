# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=poetry

PYTHON_COMPAT=( python3_{12..13} )

inherit desktop distutils-r1 xdg

DESCRIPTION="Graphical application to manage and use Nitrokey 3 devices"
HOMEPAGE="https://github.com/Nitrokey/nitrokey-app2 https://pypi.org/project/nitrokeyapp/"
SRC_URI="https://github.com/Nitrokey/nitrokey-app2/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/nitrokey-0.2.3[${PYTHON_USEDEP}]
		<dev-python/nitrokey-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/pyside-6.6.0:6=[core,gui,svg,tools,uitools,widgets,${PYTHON_USEDEP}]
		>=dev-python/usb-monitor-1.21[${PYTHON_USEDEP}]
	')
"

src_prepare() {
	distutils-r1_src_prepare

	rm nitrokeyapp/VERSION || die
	rm nitrokeyapp/ui/i18n/*.ts || die
	rm nitrokeyapp/ui/i18n/CMakeLists.txt || die

	rm -r nitrokeyapp/ui/{LICENSES,3RDPARTY.txt} || die
}

src_install() {
	distutils-r1_src_install

	domenu meta/com.nitrokey.nitrokey-app2.desktop
	newicon -s scalable meta/nk-app2.svg com.nitrokey.nitrokey-app2.svg
	newicon -s 128 meta/nk-app2.png com.nitrokey.nitrokey-app2.png

	insinto /usr/share/metainfo
	doins meta/com.nitrokey.nitrokey-app2.metainfo.xml
}
