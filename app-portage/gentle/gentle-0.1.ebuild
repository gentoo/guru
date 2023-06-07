# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1 optfeature

DESCRIPTION="Gentoo Lazy Entry - a metadata.xml generator"
HOMEPAGE="https://git.sysrq.in/gentle"
SRC_URI="https://git.sysrq.in/${PN}/snapshot/${P}.tar.xz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( app-text/xmldiff[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "toml support" dev-python/tomli
	optfeature "yaml support" dev-python/pyyaml
}
