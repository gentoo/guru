# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Gentoo Linux updater"
HOMEPAGE="https://github.com/Lab-Brat/gentoo_update"
SRC_URI="https://github.com/Lab-Brat/gentoo_update/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gentoo_update_cleanup gentoo_update_checkrestart"

RDEPEND="
	gentoo_update_cleanup? ( app-portage/gentoolkit )
	gentoo_update_checkrestart? ( app-admin/needrestart )
"

distutils_enable_tests unittest

python_test() {
	cd tests || die
	eunittest
}
