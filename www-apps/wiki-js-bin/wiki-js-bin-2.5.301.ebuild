# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit webapp

MY_PN="${PN/-bin/}"
DESCRIPTION="Modern, lightweight and powerful wiki app built on Nodejs"
HOMEPAGE="
	https://js.wiki/
	https://github.com/Requarks/wiki
"
SRC_URI="https://github.com/requarks/wiki/releases/download/v${PV}/${MY_PN}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"

LICENSE="AGPL-3"
KEYWORDS="~amd64"

RDEPEND="
	acct-group/wikijs
	acct-user/wikijs
	>=net-libs/nodejs-18[npm]"

src_install() {
	webapp_src_preinst

	dodoc LICENSE
	rm LICENSE || die

	newconfd "${FILESDIR}"/${MY_PN}.confd ${MY_PN}
	newinitd "${FILESDIR}"/${MY_PN}.initd ${MY_PN}

	[[ -f config.yml ]] || cp config.sample.yml config.yml

	insinto "${MY_HTDOCSDIR#${EPREFIX}}"
	doins -r .

	keepdir "${MY_HTDOCSDIR}"/data

	webapp_serverowned -R "${MY_HTDOCSDIR}"/data
	webapp_serverowned "${MY_HTDOCSDIR}"/config.sample.yml
	webapp_configfile "${MY_HTDOCSDIR}"/config.yml

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
