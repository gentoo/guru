# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit webapp

DESCRIPTION="A free, self-hostable news aggregator"
HOMEPAGE="
	https://freshrss.org/
	https://github.com/FreshRSS/FreshRSS
"
SRC_URI="https://github.com/FreshRSS/FreshRSS/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/FreshRSS-${PV}"

LICENSE="AGPL-3"
KEYWORDS="~amd64"
IUSE="mysql +postgres sqlite"
REQUIRED_USE="|| ( mysql postgres sqlite )"

RDEPEND="
	dev-lang/php[ctype,curl,fileinfo,fpm,jit,mysql?,pdo,postgres?,sqlite?,unicode,xml,zip,zlib]
	virtual/httpd-php
"
DEPEND="${RDEPEND}"

need_httpd_fastcgi

PATCHES=(
	"${FILESDIR}"/disable-network-tests.patch
)

src_compile() {
	:
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned "${MY_HTDOCSDIR}"/data
	webapp_serverowned "${MY_HTDOCSDIR}"/data/{index.html,cache,favicons,fever,users,users/_,tokens}
	webapp_serverowned "${MY_HTDOCSDIR}"/data/{cache,favicons,fever,users,users/_,tokens}/index.html

	webapp_src_install
}
