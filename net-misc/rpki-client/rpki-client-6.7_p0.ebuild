# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

MY_PN="${PN}-portable"
MY_PV="${PV/_p/p}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Portability shim for OpenBSD's rpki-client"
HOMEPAGE="https://rpki-client.org/"
SRC_URI="https://github.com/${PN}/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/${PN}/${PN}-openbsd.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	acct-group/_rpki-client
	acct-user/_rpki-client
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${PN}-${PV%_*}-update.patch"
)

S="${WORKDIR}/${MY_P}"

src_unpack() {
	default

	EGIT_BRANCH=$(cat "${S}"/OPENBSD_BRANCH)
	EGIT_CHECKOUT_DIR="${S}/openbsd"
	git-r3_fetch
	git-r3_checkout
}

src_prepare() {
	default

	cd "${S}"
	./autogen.sh

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--with-rsync=rsync
		--with-base-dir="/var/cache/${PN}"
		--with-output-dir="/var/db/${PN}"
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" BINDIR="/usr/bin" MANDIR="/usr/share/man" install
	insinto /etc/rpki
	doins *.tal
	keepdir "/var/db/${PN}/"
	fowners -R _rpki-client "/var/db/${PN}/"
}
