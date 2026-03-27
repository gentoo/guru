# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature

DESCRIPTION="A pytest plugin that snapshots requests made with popular Python HTTP clients"
HOMEPAGE="
	https://github.com/karpetrosyan/http-snapshot
	https://pypi.org/project/http-snapshot/
"
SRC_URI="
	https://github.com/karpetrosyan/http-snapshot/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/inline-snapshot-0.27.2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
		>=dev-python/requests-2.32.5[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( inline-snapshot anyio )
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	cat >> pyproject.toml <<-EOF || die
		[build-system]
		requires = ["hatchling"]
		build-backend = "hatchling.build"
	EOF
}

pkg_postinst() {
	optfeature_header "Install supported HTTP clients:"
	optfeature "httpx" dev-python/httpx
	optfeature "requests" dev-python/requests
}
