# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="Daemon which provides TLS client policy for Postfix via socketmap"
HOMEPAGE="
	https://github.com/Snawoot/postfix-mta-sts-resolver
	https://pypi.org/project/postfix-mta-sts-resolver/
"
SRC_URI="https://github.com/Snawoot/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install

	newinitd "${FILESDIR}"/mtasts-initd mta-sts
	newconfd "${FILESDIR}"/mtasts-confd mta-sts
	insinto /etc/
	newins "${FILESDIR}"/mtasts-config mta-sts-daemon.yml
}

pkg_postinst() {
	optfeature "PostgreSQL support" dev-python/asyncpg
	optfeature "Redis support" dev-python/redis
	optfeature "SQLite support" dev-python/aiosqlite
	optfeature "uvloop support" dev-python/uvloop
}
