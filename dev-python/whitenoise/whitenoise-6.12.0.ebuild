# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..15} )

inherit distutils-r1 optfeature

DESCRIPTION="Radically simplified static file serving for Python web apps"
HOMEPAGE="https://whitenoise.readthedocs.io/"
SRC_URI="https://github.com/evansd/whitenoise/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/django[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		app-arch/brotli[${PYTHON_USEDEP},python]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "Brotli compression" "app-arch/brotli[python]"
}
