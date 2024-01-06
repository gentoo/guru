# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Daemon which provides TLS client policy for Postfix via socketmap, according to domain MTA-STS policy"
HOMEPAGE="https://github.com/Snawoot/postfix-mta-sts-resolver https://pypi.org/project/postfix-mta-sts-resolver/"
SRC_URI="https://github.com/Snawoot/postfix-mta-sts-resolver/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="uvloop sqlite redis postgres"

DOCS="README.md"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	postgres? (
		dev-python/asyncpg[${PYTHON_USEDEP}]
	)
	sqlite? (
		dev-python/aiosqlite[${PYTHON_USEDEP}]
	)
	redis? (
		dev-python/redis[${PYTHON_USEDEP}]
	)
	uvloop? (
		dev-python/uvloop[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_install() {
	distutils-r1_python_install

	newinitd "${FILESDIR}"/mtasts-initd mta-sts
	newconfd "${FILESDIR}"/mtasts-confd mta-sts
	insinto /etc/
	newins "${FILESDIR}"/mtasts-config mta-sts-daemon.yml
}
