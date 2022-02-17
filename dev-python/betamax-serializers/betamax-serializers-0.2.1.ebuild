# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{8..10} )
inherit distutils-r1 optfeature

DESCRIPTION="A set of third-party serializers for Betamax"
HOMEPAGE="https://pypi.org/project/betamax-serializers https://gitlab.com/betamax/serializers"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/betamax[${PYTHON_USEDEP}]"

DOCS=( {AUTHORS,HISTORY,README}.rst )

pkg_postinst() {
	optfeature "YAML serializer support" dev-python/pyyaml
}
