# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 optfeature pypi

DESCRIPTION="A set of third-party serializers for Betamax"
HOMEPAGE="https://pypi.org/project/betamax-serializers/ https://gitlab.com/betamax/serializers"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/betamax[${PYTHON_USEDEP}]"

DOCS=( {AUTHORS,HISTORY,README}.rst )

pkg_postinst() {
	optfeature "YAML serializer support" dev-python/pyyaml
}
