# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

COMMIT="554e60bf52e3fa931661b9414189a92bb8f69d78"
DESCRIPTION="Among Us, but it's a text adventure"
HOMEPAGE="https://sr.ht/~martijnbraam/among-sus"
SRC_URI="https://tildegit.org/tildeverse/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+notifications"

src_configure() {
	append-cppflags \
		-DVERSION=\\\"${COMMIT:0:7}\\\" \
		-DMOVEMENT_NOTIFICATIONS=$(usex notifications 1 0)
}

src_compile() {
	emake main
}

src_install() {
	newbin main ${PN}
	einstalldocs

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}
