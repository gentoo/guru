# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Python version of the Playwright testing and automation library"
HOMEPAGE="https://github.com/microsoft/playwright-python"
SRC_URI="https://github.com/microsoft/playwright-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/playwright-python-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-util/playwright

	dev-python/greenlet[${PYTHON_USEDEP}]
	dev-python/pyee[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${PN}-1.64.0-look-up-playwright-from-the-PATH.patch"
)

EPYTEST_IGNORE=(
	"playwright/_impl/__pyinstaller"
)

distutils_enable_tests import-check

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_prepare_all() {
	# Installs a Python wrapper around the driver that
	# does nothing except calling the driver
	sed -e '/\[project\.scripts\]/,/^\s*$/d' -i pyproject.toml || die

	# Tries to download and extract the driver,
	# but we have it in the system already
	rm setup.py

	distutils-r1_python_prepare_all
}

python_test() {
	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die
	epytest --import-check
}
