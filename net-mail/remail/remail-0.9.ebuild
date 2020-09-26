# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 )

inherit distutils-r1 systemd

DESCRIPTION="A set of tools for crypted mailing lists"
HOMEPAGE="https://git.kernel.org/pub/scm/linux/kernel/git/tglx/remail.git/about/"
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/tglx/remail.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples systemd"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]
"

RDEPEND="${PYTHON_DEPS}
	dev-python/flufl-bounce[${PYTHON_USEDEP}]
	>=dev-python/m2crypto-0.35.2[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/python-gnupg[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${P}-setup.patch" )

python_compile() {
	distutils-r1_python_compile

	emake -C Documentation man
	use doc && emake -C Documentation html
}

python_install_all() {
	doman Documentation/output/man/*

	use doc && local HTML_DOCS=( Documentation/output/html/. )
	distutils-r1_python_install_all

	use examples && dodoc -r Documentation/examples
	use systemd && systemd_dounit remail.service
}
