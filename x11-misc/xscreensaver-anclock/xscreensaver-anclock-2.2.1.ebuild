# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Analog clock hack for the xscreensaver program"
HOMEPAGE="http://pt2k.xii.jp/software/anclock/xscreensaver/index_e.html"
SRC_URI="https://www.jwz.org/xscreensaver/xscreensaver-6.05.1.tar.gz \
http://pt2k.xii.jp/software/anclock/xscreensaver/oldver/anclock-${PV}-for-xscreensaver-6.04.patch.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="
	dev-libs/libxml2
	x11-apps/appres
	x11-apps/xwininfo
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXt
	x11-libs/libXxf86vm
	virtual/libcrypt:=
	virtual/glu
	virtual/opengl
	sys-libs/pam
	x11-libs/libXft
"
RDEPEND="
	>=x11-misc/xscreensaver-6.01
"
DEPEND="
	${COMMON_DEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	dev-util/intltool
	sys-devel/bc
	sys-devel/gettext
	virtual/pkgconfig
"
PATCHES=(
	"${FILESDIR}"/xscreensaver-6.01-interix.patch
	"${FILESDIR}"/xscreensaver-5.31-pragma.patch
	"${FILESDIR}"/xscreensaver-6.01-gentoo.patch
	"${FILESDIR}"/xscreensaver-5.45-gcc.patch
	"${FILESDIR}"/xscreensaver-6.01-configure.ac-sandbox.patch
	"${FILESDIR}"/xscreensaver-6.01-without-gl-makefile.patch
	"${FILESDIR}"/xscreensaver-6.01-configure-install_sh.patch
	"${FILESDIR}"/xscreensaver-6.03-without-gl-configure.patch
	"${FILESDIR}"/xscreensaver-6.05-configure-exit-codes.patch
)

S="${WORKDIR}"/xscreensaver-6.05/

src_unpack() {
	default
	gunzip --force "${DISTDIR}/anclock-${PV}-for-xscreensaver-6.04.patch.gz"
}

src_prepare() {
	default
	config_rpath_update "${S}"/config.rpath

	eapply "${WORKDIR}"/anclock-"${PV}"-for-xscreensaver-6.04.patch

	# Must be eauto*re*conf, to force the rebuild
	eautoreconf
}

src_configure() {
	if use ppc || use ppc64; then
		filter-flags -maltivec -mabi=altivec
		append-flags -U__VEC__
	fi

	unset BC_ENV_ARGS #24568

	# /proc/interrupts won't always have the keyboard bits needed
	# Not clear this does anything in 6.03+(?) but let's keep it for now in case.
	# (See also: configure argument)
	export ac_cv_have_proc_interrupts=yes

	# WARNING: This is NOT a normal autoconf script
	# Some of the --with options are NOT standard, and expect "--with-X=no" rather than "--without-X"
	ECONF_OPTS=(
		--enable-locking
		--without-elogind
		--without-pixbuf
		--without-gles
		--without-glx
		--without-gtk
		--without-login-manager
		--with-gl
		--with-pam
		--without-setuid-hacks
		--without-systemd
		--without-xinerama-ext
		--with-jpeg=yes
		--with-png=no
		--with-xft=yes
		--with-app-defaults="${EPREFIX}"/usr/share/X11/app-defaults
		--with-configdir="${EPREFIX}"/usr/share/${PN}/config
		--with-dpms-ext
		--with-hackdir="${EPREFIX}"/usr/$(get_libdir)/misc/${PN}
		--with-proc-interrupts
		--with-randr-ext
		--with-text-file="${EPREFIX}"/etc/gentoo-release
		--with-xdbe-ext
		--with-xf86gamma-ext
		--with-xf86vmode-ext
		--with-xinput-ext
		--with-xkb-ext
		--with-xshm-ext
		--without-gle
		--without-kerberos
		--without-motif
		--with-proc-oom
		--x-includes="${EPREFIX}"/usr/include
		--x-libraries="${EPREFIX}"/usr/$(get_libdir)
	)
	# WARNING: This is NOT a normal autoconf script
	econf "${ECONF_OPTS[@]}"
}

src_compile() {
	# stock target is "default", which is broken in some releases of xscreensaver
	emake all
}

src_install() {
	insinto /usr/share/xscreensaver/config
	doins hacks/config/anclock.xml
	mv hacks/{anclock.man,anclock.6} || die
	doman hacks/anclock.6
	exeinto /usr/lib64/misc/xscreensaver
	doexe hacks/anclock
}

pkg_postinst() {
	elog ""
	elog "To add the anclock screensaver to xscreensaver-settings, add the line"
	elog "'anclock --root' to the 'programs:' section in the file"
	elog "~/.xscreensaver in your home-directory."
	elog "e.g. run 'sed -i '/programs:/a anclock --root' ~/.xscreensaver'"
}
