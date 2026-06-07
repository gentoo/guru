# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1 optfeature

DESCRIPTION="A simple deSEC.io API client"
HOMEPAGE="https://github.com/s-hamann/desec-dns"
SRC_URI="https://github.com/s-hamann/desec-dns/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# TODO: 9999 (pyproject versioning?)

IUSE="test"
DEPEND="
	>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-recording[${PYTHON_USEDEP}]
		dev-python/dnspython[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest

python_prepare_all() {
	default
	distutils-r1_python_prepare_all

	# https://projects.gentoo.org/python/guide/qawarn.html#stray-top-level-files-in-site-packages
	sed -i 's/include = \["CHANGELOG.md"\]//' pyproject.toml || die "failed to sed pyproject.toml (exclude CHANGELOG.md)"

	sed -i 's/version = "0.0.0"/version = "v'${PV}'"/' pyproject.toml || die "failed to sed pyproject.toml (fix version)"
}

python_install_all() {
	default
	dodoc "CHANGELOG.md"
}

pkg_postinst() {
	optfeature "TLSA record management support" dev-python/cryptography
	optfeature "zonefile parsing support" dev-python/dnspython
}
