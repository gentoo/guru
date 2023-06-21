# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 optfeature

DESCRIPTION="Gentoo Linux updater"
HOMEPAGE="https://github.com/Lab-Brat/gentoo_update"
SRC_URI="https://github.com/Lab-Brat/gentoo_update/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests unittest

python_test() {
	cd tests || die
	eunittest
}

pkg_postinst() {
	optfeature "--clean support" app-portage/gentoolkit
	optfeature "--daemon-restart support" app-admin/needrestart
}
