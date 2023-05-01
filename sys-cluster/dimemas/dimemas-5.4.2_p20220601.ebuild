# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="0dc28fafb8a917cee8d6ffd4a037cdc1f8755101"
PYTHON_COMPAT=( pypy3 python3_{10..11} )

inherit autotools java-pkg-opt-2 python-any-r1

DESCRIPTION="High-abstracted network simulator for message-passing programs"
HOMEPAGE="https://github.com/bsc-performance-tools/dimemas"
SRC_URI="https://github.com/bsc-performance-tools/dimemas/archive/${COMMIT}.tar.gz -> ${PF}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="idle-accounting irecv-startup original-links wait-logical-recv"

CDEPEND="
	dev-libs/boost:=
	sys-libs/zlib
	java? ( dev-java/commons-io:1 )
"
DEPEND="
	${CDEPEND}
	${PYTHON_DEPS}
	java? ( virtual/jdk:1.8 )
"
RDEPEND="
	${CDEPEND}
	java? ( virtual/jre:1.8 )
"

PATCHES=( "${FILESDIR}/${PN}-5.4.2-gui.patch" )

src_prepare() {
	default
	java-pkg_clean
	if use java; then
		pushd ./GUI/lib || die
		java-pkg_jar-from commons-io-1 commons-io.jar commons-io-2.4.jar
		popd || die
	fi
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-boost="${EPREFIX}/usr"
		--with-boost-libdir="${EPREFIX}/usr/$(get_libdir)"

		$(use_enable idle-accounting)
		$(use_enable irecv-startup)
		$(use_enable original-links)
		$(use_enable wait-logical-recv)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	dodoc README.md ChangeLog
	mkdir -p "${ED}/usr/share/doc/${PF}/examples" || die
	mv "${ED}/usr/share/lib_extern_model_example" "${ED}/usr/share/doc/${PF}/examples/" || die
	docompress -x "${ED}/usr/share/doc/${PF}/examples"
	mkdir -p "${ED}/usr/share/${PN}" || die
	mv "${ED}/usr/share/cfgs" "${ED}/usr/share/${PN}/" || die
	if use java; then
		java-pkg_newjar "${ED}/usr/$(get_libdir)/GUI/dimemas-gui-5.4.2.jar" "dimemas-gui.jar"
		rm -r "${ED}/usr/$(get_libdir)/GUI" || die
	fi
	find "${ED}" -name '*.la' -delete || die
}
