# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Tweak the form field rendering in templates"
HOMEPAGE="
	https://pypi.org/project/django-widget-tweaks/
	https://github.com/jazzband/django-widget-tweaks
"
SRC_URI="https://github.com/jazzband/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( ${RDEPEND} )
"

DOCS=( {CHANGES,README}.rst {CODE_OF_CONDUCT,CONTRIBUTING}.md )

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_test() {
	"${EPYTHON}" -m django test -v 2 --settings tests.settings ||
		die "Tests failed with ${EPYTHON}"
}
