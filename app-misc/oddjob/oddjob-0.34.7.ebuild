# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit autotools systemd

DESCRIPTION="A D-Bus service which runs odd jobs on behalf of client applications"

HOMEPAGE="https://pagure.io/oddjob"
SRC_URI="https://releases.pagure.org/oddjob/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples pam selinux"

RESTRICT="test"

RDEPEND="sys-apps/dbus[selinux?]
	pam? ( sys-libs/pam )
	selinux? (
		sec-policy/selinux-oddjob
		sys-libs/libselinux
	 )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	doc? ( app-text/docbook-xml-dtd:4.3
		app-text/xmlto
	)"

PATCHES=(
	"${FILESDIR}/${PN}-0.34.7-build-Fix-broken-AC_ARG_ENABLE-install-logic.patch"
	"${FILESDIR}/${PN}-0.34.7-build-Keep-non-PAM-mkhomedir-parts-when-PAM-support-.patch"
	"${FILESDIR}/${PN}-0.34.7-build-Remove-with-systemd-and-with-sysvinit.patch"
	"${FILESDIR}/${PN}-0.34.7-build-Restore-conditional-with-pam-flag.patch"
	"${FILESDIR}/${PN}-0.34.7-src-oddjobd.c-Fix-non-selinux-build.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	 local myeconfargs=(
		--libdir=/$(get_libdir)
		$(use_with pam)
		$(use_with selinux selinux-labels)
		$(use_with selinux selinux-acls)
		$(use_enable examples sample)
		$(use_enable doc xml-docs)
		$(use_enable doc compat-dtd)
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default
	rm -f "${ED}/etc/rc.d/init.d/oddjobd"
	newinitd "${FILESDIR}/oddjob.init.d" "oddjobd"

	find "${ED}" -iname \*.la -type f -delete
}
