# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3 meson

DESCRIPTION="Xscreensaver screensavers ported to wayland"
HOMEPAGE="https://git.sr.ht/~mstoeckl/wscreensaver"

EGIT_REPO_URI="https://git.sr.ht/~mstoeckl/${PN}"

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-libs/glib:2
	dev-libs/wayland
	media-libs/glu
	media-libs/libglvnd
	x11-libs/gdk-pixbuf:2
"
DEPEND="
	${RDEPEND}
	media-libs/libpng
"
BDEPEND="
	dev-util/intltool
	sys-devel/bc
	sys-devel/gettext
	virtual/pkgconfig
	x11-base/xorg-proto
"

PATCHES=(
	"${FILESDIR}"/xscreensaver-5.31-pragma.patch
	"${FILESDIR}"/xscreensaver-6.01-gentoo.patch
	"${FILESDIR}"/xscreensaver-5.45-gcc.patch
)

# see https://bugs.gentoo.org/898328
QA_CONFIG_IMPL_DECL_SKIP=( getspnam_shadow )

src_configure() {
	econf
	local S="$S"/wayland
	# Will write a patch later and send it to upstream.
	# For now accept it.
	if [[ $CC == clang* ]]; then
		append-cflags -Wno-error=incompatible-function-pointer-types
	fi
	meson_src_configure
}

src_compile() {
	emake
	local S="$S"/wayland
	meson_src_compile
}

src_install() {
	local filename
	local S="${WORKDIR}/wscreensaver-${PV}-build"
	insinto /usr/lib64/misc/"${PN}"
	for file in  "${S}"/*; do
		# exclude all files that have a contain a . e.g. have a file extension
		# or contain the word meson-
		filename=$(basename "${file}")
		if [[ "${filename}" != *.* && "${filename}" != *meson-*  ]]; then
			doins "${file}"
			fperms +x /usr/$(get_libdir)/misc/"${PN}"/"${filename}"
		fi
	done
}
