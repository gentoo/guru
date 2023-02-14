# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A fixtures replacement tool"
HOMEPAGE="https://github.com/FactoryBoy/factory_boy"
SRC_URI="https://github.com/FactoryBoy/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/Faker-0.7.0[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		$(python_gen_impl_dep sqlite)
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/pillow[jpeg,${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/factory_boy[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	# Fix symbolic link QA
	rm ChangeLog || die "remove failed"
	cp docs/changelog.rst ChangeLog || die "copy failed"

	# depends on masked dev-python/mongoengine
	rm tests/test_mongoengine.py || die

	distutils-r1_python_prepare_all
}

distutils_enable_tests --install unittest

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme dev-python/sphinxcontrib-spelling
