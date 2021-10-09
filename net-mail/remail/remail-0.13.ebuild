# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 systemd

DESCRIPTION="A set of tools for crypted mailing lists"
HOMEPAGE="https://git.kernel.org/pub/scm/linux/kernel/git/tglx/remail.git/about/"
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/tglx/remail.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples systemd"

RDEPEND="${PYTHON_DEPS}
	dev-python/flufl-bounce[${PYTHON_USEDEP}]
	>=dev-python/m2crypto-0.35.2[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/python-gnupg[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${P}-setup.patch" )

distutils_enable_sphinx Documentation --no-autodoc

python_install_all() {
	distutils-r1_python_install_all

	use examples && dodoc -r Documentation/examples
	use systemd && systemd_dounit remail.service
}
