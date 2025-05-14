# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

MY_P="sentry-python-${PV}"
DESCRIPTION="Python client for Sentry"

HOMEPAGE="
	https://sentry.io/
	https://github.com/getsentry/sentry-python/
	https://pypi.org/project/sentry-sdk/
"

SRC_URI="https://github.com/getsentry/sentry-python/archive/${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	>=dev-python/urllib3-1.26.11[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
"

DOCS=(
	CHANGELOG.md
	CONTRIBUTING.md
	MIGRATION_GUIDE.md
	README.md
)
