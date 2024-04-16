# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-vm-2 toolchain-funcs

MY_PV=${PV/_p/+}
SLOT=$(ver_cut 1)

SRC_URI="
    https://corretto.aws/downloads/resources/${PV}/amazon-corretto-${PV}-linux-x64.tar.gz
"

DESCRIPTION="Prebuilt Java JDK binaries provided by Amazon Web Services"
HOMEPAGE="https://aws.amazon.com/corretto"
LICENSE="GPL-2-with-classpath-exception"
KEYWORDS="~amd64"
IUSE="cups headless-awt selinux source"

RDEPEND="
	>=sys-apps/baselayout-java-0.1.0-r1
	kernel_linux? (
		media-libs/fontconfig:1.0
		media-libs/freetype:2
		media-libs/harfbuzz
		media-libs/alsa-lib
		media-libs/libglvnd
		elibc_glibc? ( >=sys-libs/glibc-2.2.5:* )
		elibc_musl? ( sys-libs/musl )
		sys-libs/zlib
		cups? ( net-print/cups )
		selinux? ( sec-policy/selinux-java )
		!headless-awt? (
			app-accessibility/at-spi2-core
			x11-libs/gtk+
			x11-libs/gdk-pixbuf
			x11-libs/libXxf86vm
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXi
			x11-libs/libXrender
			x11-libs/libXtst
			x11-libs/pango
		)
	)"

RESTRICT="preserve-libs splitdebug"
QA_PREBUILT="*"

S="${WORKDIR}/amazon-corretto-${MY_PV}-linux-x64"

pkg_pretend() {
	if [[ "$(tc-is-softfloat)" != "no" ]]; then
		die "These binaries require a hardfloat system."
	fi
}

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}/${dest#/}"

	if use headless-awt ; then
		rm -v lib/amd64/libjawt.so || die
		rm -v lib/amd64/libglassgtk.so || die
		rm -v lib/amd64/libjavafx_font_pango.so || die
		rm -v jre/lib/amd64/libglassgtk2.so || die
		rm -v jre/lib/amd64/libprism_es2.so || die
	fi

	if ! use source ; then
		rm -v src.zip || die
	fi

	dodir "${dest}"
	cp -pPR * "${ddest}" || die

	# provide stable symlink
	dosym "${P}" "/opt/${PN}-${SLOT}"

	java-vm_install-env "${FILESDIR}"/${PN}-8.env.sh
	java-vm_set-pax-markings "${ddest}"
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}

pkg_postinst() {
	java-vm-2_pkg_postinst
}