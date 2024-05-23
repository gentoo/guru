# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=(python3_{9..12})

inherit linux-mod-r1 distutils-r1 desktop

DESCRIPTION="Run Windows Applications on Linux as if they are native (Using a VM and FreeRDP)"
HOMEPAGE="https://github.com/casualsnek/cassowary"
SRC_URI="https://github.com/casualsnek/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="X wayland"

BDEPEND="dev-python/setuptools
	dev-python/build
	dev-python/installer
"

RDEPEND="net-misc/freerdp
	dev-python/libvirt-python
	dev-python/PyQt5
"

DEPEND="${RDEPEND}"

MODULES_KERNEL_MIN=5.10

python_compile() {
	cd "${S}/app-linux" || die
	echo "See documenation of cassowary" >README.md || die      # Dummy Readme file (solve qa error)
	sed -i "s/version = 0.5/version = ${PV}/g" setup.cfg || die #version typo upstream
	${EPYTHON} -m build --wheel --no-isolation
}

python_install() {
	cd "${S}/app-linux" || die
	${EPYTHON} -m installer --destdir="${D}" dist/cassowary-${PV}-py3-none-any.whl
	domenu "${FILESDIR}/cassowary.desktop"
	doicon "${S}/app-linux/src/cassowary/gui/extrares/cassowary.png"
}

pkg_postinst() {
	ewarn "This application requires Pre-Configuration"
	ewarn "Pls Follow the docs of the project:"
	ewarn "https://github.com/casualsnek/cassowary/docs"
}
