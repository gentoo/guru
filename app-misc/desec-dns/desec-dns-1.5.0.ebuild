# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1 optfeature pypi shell-completion

DESCRIPTION="A simple deSEC.io API client"
HOMEPAGE="https://github.com/s-hamann/desec-dns"
# source dists note: upstream fills in version and man page date in pypi
# sdists and custom .tar.gz provided by upstream. this ebuild now assumes
# it's getting that

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# TODO: 9999 (pyproject versioning?)

# maintainers note: tests are probably broken, because
# >=dev-python/aiohttp-3.14.0 broke <dev-python/vcrpy-8.3.0. fixed version
# is currently ~dev-python/vcrpy-8.3.0, which is currently ~ keyworded at
# the moment, stabilization pending.
DEPEND="
	>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
	test? (
		dev-python/dnspython[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

EPYTEST_PLUGINS=(
	pytest-recording
)
distutils_enable_tests pytest

python_install_all() {
	default
	dodoc "CHANGELOG.md"
	doman man/desec.1
	dozshcomp completions/_desec
	newbashcomp completions/desec.bash desec
}

pkg_postinst() {
	optfeature "TLSA record management support" dev-python/cryptography
	optfeature "zonefile parsing support" dev-python/dnspython
}
