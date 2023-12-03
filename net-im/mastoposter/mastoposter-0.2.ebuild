# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1 pypi systemd

DESCRIPTION="Configurable reposter from Mastodon-compatible Fediverse servers"
HOMEPAGE="
	https://pypi.org/project/mastoposter/
	https://github.com/hatkidchan/mastoposter
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/mastoposter
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/emoji[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install

	systemd_dounit "${FILESDIR}"/mastoposter.service
	newinitd "${FILESDIR}"/mastoposter.initd mastoposter
	newconfd "${FILESDIR}"/mastoposter.confd mastoposter

	insinto /etc/mastoposter
	insopts --mode=600 --owner=${PN} --group=${PN}
	doins config.ini
}
