# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
WANT_AUTOCONF="2.5"
inherit autotools desktop xdg-utils flag-o-matic
DESCRIPTION="Dogecoin Core Qt for desktop. Downloaded blockchain is under 2.2GB. Much secure."
HOMEPAGE="https://github.com/dogecoin"
SRC_URI="https://github.com/dogecoin/dogecoin/archive/refs/tags/v${PV}.tar.gz -> ${PN}-v${PV}.tar.gz"

WORKDIR_="${WORKDIR}/dogecoin-${PV}"
S="${WORKDIR_}"

LICENSE="MIT"
SLOT="0"
DB_VER="5.3"
KEYWORDS="~amd64 ~arm64"
IUSE="cpu_flags_x86_avx2 dogecoind +pie +prune +ssp tests utils +wallet zmq"
REQUIRED_USE="dogecoind? ( utils )"
DOGEDIR="/opt/${PN}"
DEPEND="
	sys-libs/db:"${DB_VER}"=[cxx]
	dev-libs/libevent:=
	dev-libs/protobuf
	dev-libs/openssl
	dev-build/libtool
	dev-build/automake:=
	>=dev-libs/boost-1.81.0-r1
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwidgets
	dev-qt/qtdbus
	dev-qt/qtnetwork
	dev-qt/qtprintsupport
	dev-qt/linguist-tools:=
	cpu_flags_x86_avx2? ( =app-crypt/intel-ipsec-mb-1.3 )
	wallet? ( media-gfx/qrencode )
	zmq? ( net-libs/cppzmq )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/automake
	dev-build/automake
"

PATCHES=(
	"${FILESDIR}"/"${PV}"-net_processing.patch
	"${FILESDIR}"/"${PV}"-paymentserver.patch
	"${FILESDIR}"/"${PV}"-transactiondesc.patch
	"${FILESDIR}"/"${PV}"-deque.patch
	"${FILESDIR}"/gcc13.patch
)

pkg_pretend() {

	if use cpu_flags_x86_avx2 && [[ ! -e "${ROOT}"/etc/portage/patches/app-crypt/intel-ipsec-mb/remove_digest_init.patch ]]; then
		eerror "${ROOT}/etc/portage/patches/app-crypt/intel-ipsec-mb/remove_digest_init.patch does not exist!"
		eerror "To build with avx2 intel support, please create ${ROOT}/etc/portage/patches/app-crypt/intel-ipsec-mb directory"
		eerror "and copy patch from package net-p2p/dogecoin-qt/files/intel-ipsec-mb/remove_digest_init.patch into that directory"
		die
	fi
}

src_prepare() {

	if use pie && use ssp ; then
		PATCHES+=( "${FILESDIR}"/hardened-all.patch )
	elif use pie && ! use ssp ; then
		PATCHES+=( "${FILESDIR}"/hardened-no-ssp.patch )
	elif use ssp && ! use pie ; then
		PATCHES+=( "${FILESDIR}"/hardened-no-pie.patch )
	else
		PATCHES+=( "${FILESDIR}"/hardened-minimal.patch )
	fi

	default

	einfo "Generating autotools files..."
	eaclocal -I "${WORKDIR_}"
	eautoreconf
}

src_configure() {
	local my_econf=(
		--bindir="${DOGEDIR}/bin"
		--with-gui=qt5
		--disable-bench
		$(use_with cpu_flags_x86_avx2 intel-avx2)
		$(use_with dogecoind daemon)
		$(use_with utils utils)
		$(use_enable wallet)
		$(use_enable zmq)
		$(use_enable tests tests)
	)

	append-cxxflags "-std=c++14"
	econf "${my_econf[@]}"
}

src_install() {
	emake DESTDIR="${D}" install
	insinto "${DOGEDIR}/bin"
	insinto /usr/share/pixmaps
	doins src/qt/res/icons/dogecoin.png
	dosym "${DOGEDIR}/bin/${PN}" "/usr/bin/${PN}"

	if use dogecoind ; then
		dosym "${DOGEDIR}/bin/dogecoind" "/usr/bin/dogecoind"
		dosym "${DOGEDIR}/bin/dogecoin-cli" "/usr/bin/dogecoin-cli"
	fi

	if use prune ; then
		domenu "${FILESDIR}"/"${PN}-prune.desktop"
	else
		domenu "${FILESDIR}"/"${PN}.desktop"
	fi

	find "${ED}" -type f -name '*.la' -delete || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	elog "Dogecoin Core Qt ${PV} has been installed."
	elog "Dogecoin Core Qt binaries have been placed in ${DOGEDIR}/bin."
	elog "${PN} has been symlinked with /usr/bin/${PN}."

	if use dogecoind ; then
		elog "dogecoin daemon has been symlinked with /usr/bin/dogecoind."
		elog "dogecoin client utils have been symlinked with /usr/bin/dogecoin-cli."
	fi
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
