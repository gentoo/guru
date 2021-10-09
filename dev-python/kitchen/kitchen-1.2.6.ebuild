# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} pypy3 )
inherit distutils-r1

DESCRIPTION="Kitchen contains a cornucopia of useful code"
HOMEPAGE="https://github.com/fedora-infra/kitchen"
SRC_URI="https://github.com/fedora-infra/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( HACKING.rst NEWS.rst README.rst )

distutils_enable_tests nose

# Could not import extension sphinx.ext.pngmath
#distutils_enable_sphinx kitchen3/docs

python_test() {
	local noseopts=(
		--exclude=test_invalid_fallback_no_raise
		--exclude=test_lgettext
		--exclude=test_lngettext
		--exclude=test_easy_gettext_setup_non_unicode
		# fail with python 3.9
		--exclude=test_internal_generate_combining_table
		# fail with python 3.10
		#--exclude=check__all__is_complete
	)
	nosetests -w kitchen3 -v "${noseopts[@]}" || die
}
