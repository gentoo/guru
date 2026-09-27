# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Versatile test fixtures replacement based on thoughtbot's factory_bot"
HOMEPAGE="
	https://github.com/FactoryBoy/factory_boy
	https://pypi.org/project/factory-boy/"
SRC_URI="https://github.com/FactoryBoy/factory_boy/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/factory_boy-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/faker-0.7.0[${PYTHON_USEDEP}]"

BDEPEND="
	test? (
		${RDEPEND}
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-django )
EPYTEST_IGNORE=(
	# flask_sqlalchemy not packaged
	examples/flask_alchemy/test_demoapp.py )
EPYTEST_DESELECT=(
	# completely broken ("setup_test_environment() was already called and can't
	# be called again without first calling teardown_test_environment().")
	tests/test_django.py )
distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install

	# Package installs broken "ChangeLog" symlink which points to changelog.rst,
	# so let's install that instead.
	rm "${ED}"/usr/share/doc/"${PF}"/ChangeLog || die
	dodoc docs/changelog.rst
}
