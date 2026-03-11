# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=no
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 systemd

DESCRIPTION="Proxy server to bypass Cloudflare protection"
HOMEPAGE="https://github.com/FlareSolverr/FlareSolverr"
SRC_URI="https://github.com/FlareSolverr/FlareSolverr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/FlareSolverr-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	acct-group/flaresolverr
	acct-user/flaresolverr

	|| (
		www-client/google-chrome
		www-client/chromium
	)

	$(python_gen_cond_dep '
		dev-python/bottle[${PYTHON_USEDEP}]
		dev-python/func-timeout[${PYTHON_USEDEP}]
		dev-python/prometheus-client[${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]
		dev-python/waitress[${PYTHON_USEDEP}]

		dev-python/certifi[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/websockets[${PYTHON_USEDEP}]

		dev-python/xvfbwrapper[${PYTHON_USEDEP}]
	')
"

python_install() {
	sed -i -e "1i#!${EPREFIX}/usr/bin/${EPYTHON}" "src/flaresolverr.py" || die

	python_moduleinto flaresolverr
	python_domodule src/* package.json

	fperms +x "/usr/lib/${EPYTHON}/site-packages/${PN}/flaresolverr.py"
	dosym -r "$_" "/usr/bin/flaresolverr"

	dodoc LICENSE

	systemd_newunit "${FILESDIR}/flaresolverr.service" "flaresolverr.service"
}
