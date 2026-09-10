# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/standard-webhooks/standard-webhooks
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Standard Webhooks"
HOMEPAGE="
	https://github.com/standard-webhooks/standard-webhooks
	https://pypi.org/project/standardwebhooks/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# fix build backend
	# https://bugs.gentoo.org/979160
	sed -i "/^build-backend = /s/:__legacy__//" pyproject.toml || die
}
