# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 pypi

DESCRIPTION="A simple library for creating beautiful interactive prompts"
HOMEPAGE="
	https://github.com/Exahilosys/survey
	https://pypi.org/project/survey/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_sphinx docs \
	dev-python/sphinx-autodoc-typehints \
	dev-python/sphinx-paramlinks \
	dev-python/sphinx-rtd-theme
