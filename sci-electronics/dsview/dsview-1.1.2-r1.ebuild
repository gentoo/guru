# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_PN="DSView"
MY_PV="$(ver_rs 2 '')" # 'a.b.c' -> 'a.bc'
PYTHON_COMPAT=( python3_{8..10} )

inherit cmake python-r1 toolchain-funcs udev xdg

DESCRIPTION="An open source multi-function instrument"
HOMEPAGE="
	https://www.dreamsourcelab.com
	https://github.com/DreamSourceLab/DSView
"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DreamSourceLab/${GITHUB_PN}.git"
else
	SRC_URI="https://github.com/DreamSourceLab/${GITHUB_PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${GITHUB_PN}-${MY_PV}"
fi

LICENSE="GPL-3"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-cpp/glibmm:2
	dev-libs/boost
	dev-libs/glib
	dev-libs/libzip
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5
	dev-qt/qtconcurrent:5
	sci-libs/fftw:3.0
	virtual/libusb:1
"

DEPEND="
	${RDEPEND}
"

PATCHES=(
	"${FILESDIR}"/${P}-desktop.patch
	"${FILESDIR}"/${P}-cmake.patch
	"${FILESDIR}"/${P}-fix-qt.patch
	"${FILESDIR}"/${P}-fix-segfault.patch
	"${FILESDIR}"/${P}-fix-extern-c.patch
	"${FILESDIR}"/${P}-fix-python3.patch
)

src_prepare() {
	export CC="$(tc-getCC)"
	export AR="$(tc-getAR)"

	default

	local LIBDIR="/usr/$(get_libdir)"

	grep -rl "/usr/local/lib" "${S}" | xargs sed -i "s@/usr/local/lib@${LIBDIR}@g" || die
	grep -rl "/usr/local" "${S}" | xargs sed -i "s@/usr/local@/usr@g" || die
	cd "${S}/libsigrok4DSL" || die
	sh ./autogen.sh || die
	cd "${S}/libsigrokdecode4DSL" || die
	sh ./autogen.sh || die
}

src_configure() {
	local LIBDIR="/usr/$(get_libdir)"

	cd "${S}/libsigrok4DSL" || die
	sh ./configure --libdir=${LIBDIR} --prefix=/usr || die
	cd "${S}/libsigrokdecode4DSL" || die
	sh ./configure --libdir=${LIBDIR} --prefix=/usr || die
}

src_compile() {
	cd "${S}/libsigrok4DSL" || die
	emake
	cd "${S}/libsigrokdecode4DSL" || die
	emake
}

src_install() {
	local LIBDIR="/usr/$(get_libdir)"

	cd "${S}/libsigrok4DSL" || die
	emake DESTDIR="${D}" install
	cd "${S}/libsigrokdecode4DSL" || die
	emake DESTDIR="${D}" install
	cd "${S}/DSView" || die

	DESTDIR="${D}" \
	PKG_CONFIG_PATH="${D}${LIBDIR}/pkgconfig" \
	CFLAGS="-I${D}/usr/include" \
	CXXFLAGS="-I${D}/usr/include" \
	LDFLAGS="-L${D}${LIBDIR}" \
	cmake -DCMAKE_INSTALL_PREFIX=/usr . || die
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	udev_reload
	xdg_pkg_postinst
}

pkg_postrm() {
	udev_reload
	xdg_pkg_postrm
}
