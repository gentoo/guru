# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} )

inherit autotools linux-info python-any-r1

SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="Application distribution framework"
HOMEPAGE="https://flatpak.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="doc gtk introspection kde policykit seccomp systemd"

# FIXME: Automagic dep on app-arch/zstd
RDEPEND="
	acct-group/flatpak
	acct-user/flatpak
	>=app-arch/libarchive-2.8
	>=app-crypt/gpgme-1.1.8
	>=dev-libs/appstream-glib-0.5.10
	>=dev-libs/glib-2.56:2
	>=dev-libs/libxml2-2.4
	dev-libs/json-glib
	>=dev-util/ostree-2019.5[gpg(+)]
	|| ( dev-util/ostree[curl]
		 dev-util/ostree[soup] )
	>=gnome-base/dconf-0.26
	>=net-libs/libsoup-2.4
	sys-apps/dbus
	>=sys-fs/fuse-2.9.9:0
	x11-apps/xauth
	x11-libs/gdk-pixbuf:2
	policykit? ( >=sys-auth/polkit-0.98 )
	seccomp? ( sys-libs/libseccomp )
	systemd? ( sys-apps/systemd )
"

# NOTE: pyparsing for variant-schema-compiler submodule (build time)
DEPEND="${RDEPEND}"
BDEPEND=">=sys-devel/automake-1.13.4
	>=sys-devel/gettext-0.18.2
	virtual/pkgconfig
	dev-util/gdbus-codegen
	sys-devel/bison
	introspection? ( >=dev-libs/gobject-introspection-1.40 )
	doc? ( >=dev-util/gtk-doc-1.20
	       dev-libs/libxslt )
	$(python_gen_any_dep '
		dev-python/pyparsing[${PYTHON_USEDEP}]
	')
"
# FIXME: is there a nicer way to do this?
PDEPEND="
	gtk? ( >=sys-apps/xdg-desktop-portal-0.10
	       sys-apps/xdg-desktop-portal-gtk )
	kde? ( kde-plasma/xdg-desktop-portal-kde )
"

python_check_deps() {
	has_version -b "dev-python/pyparsing[${PYTHON_USEDEP}]"
}

pkg_setup() {
	local CONFIG_CHECK="~USER_NS"
	linux-info_pkg_setup
	python-any-r1_pkg_setup
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
		$(use_enable seccomp) \
		$(use_with systemd)
	)

	econf "${myeconfargs[@]}"

}
