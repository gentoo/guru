# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature

DESCRIPTION="pytest integration for aiomisc"
HOMEPAGE="
	https://github.com/aiokitchen/aiomisc-pytest
	https://pypi.org/project/aiomisc-pytest/
"

MY_COMMIT="b6f974d9ce1dc892b6c33d6e5b04a36f092b9c57" # v2.0.0 (untagged, inferred)
SRC_URI="https://github.com/aiokitchen/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/aiomisc-18[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( aiomisc-pytest )
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "uvloop" dev-python/uvloop
}
