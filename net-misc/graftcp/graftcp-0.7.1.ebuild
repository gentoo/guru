#Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A tool for redirecting a given program's TCP traffic to SOCKS5 or HTTP proxy"
HOMEPAGE="https://github.com/hmgle/graftcp"

GO_OPTIONAL=1

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hmgle/graftcp.git"
else
	SRC_URI="
	https://github.com/hmgle/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/unlsycn/${PN}/releases/download/vendor-${PV}/${PN}-local-vendor-${PV}.tar.xz -> vendor.tar.xz
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/go
	dev-util/pkgconf
"

PATCHES="
	${FILESDIR}/0001-build-not-enabling-service-in-install_systemd.patch
	${FILESDIR}/0002-build-no-longer-strip-symbols.patch
	${FILESDIR}/0003-version-v0.7.patch
"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	default
	mv "${WORKDIR}/vendor" "${WORKDIR}/${P}/local" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	emake DESTDIR="${D}" PREFIX="/usr" install_systemd
}
