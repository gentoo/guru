# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-info

SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="Application distribution framework"
HOMEPAGE="https://flatpak.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc gtk introspection kde policykit seccomp"

# restrict until fixed. Bug: 721906
RESTRICT="test"

# FIXME: systemd is automagic dep.
RDEPEND="
	acct-group/flatpak
	acct-user/flatpak
	>=dev-util/ostree-2019.5[gpg(+)]
	|| ( dev-util/ostree[curl]
		 dev-util/ostree[soup] )
	>=net-libs/libsoup-2.4
	>=gnome-base/dconf-0.26
	>=dev-libs/appstream-glib-0.5.10
	x11-libs/gdk-pixbuf:2
	>=dev-libs/glib-2.56:2
	>=dev-libs/libxml2-2.4
	sys-apps/dbus
	dev-libs/json-glib
	x11-apps/xauth
	>=app-arch/libarchive-2.8
	>=app-crypt/gpgme-1.1.8
	>=sys-fs/fuse-2.9.9:0
	policykit? ( >=sys-auth/polkit-0.98 )
	seccomp? ( sys-libs/libseccomp )
"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.18.2
	dev-util/gdbus-codegen
	introspection? ( >=dev-libs/gobject-introspection-1.40 )
	doc? ( >=dev-util/gtk-doc-1.20
	       dev-libs/libxslt )
"
BDEPEND="
	>=sys-devel/automake-1.13.4
	sys-devel/bison
	virtual/pkgconfig
"
PDEPEND="
	gtk? ( >=sys-apps/xdg-desktop-portal-0.10
	       sys-apps/xdg-desktop-portal-gtk )
	kde? ( kde-plasma/xdg-desktop-portal-kde )
"

pkg_setup() {
	local CONFIG_CHECK="~USER_NS"
	linux-info_pkg_setup
}

src_configure() {
	# FIXME: the gtk-doc check doesn't seem to be working
	# TODO: split out bubblewrap
	# TODO: split out xdg-dbus-proxy?
	# TODO: We do not provide libmalcontent yet.
	local myeconfargs=(
		--enable-sandboxed-triggers \
		--enable-xauth \
		--localstatedir="${EPREFIX}"/var \
		--without-system-bubblewrap \
		--without-system-dbus-proxy \
		$(use_enable doc documentation) \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		$(use_enable policykit system-helper) \
		$(use_enable seccomp)
	)

	econf "${myeconfargs[@]}"

}
