# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_AUTODOC=0
DOCS_BUILDER="sphinx"
DOCS_DIR="docs/wxparaver_help_contents/sphinx/2.paraver_toolset/source"
PYTHON_COMPAT=( python3_{8..10} pypy3 )
WX_GTK_VER="3.0-gtk3"

inherit autotools python-any-r1 docs wxwidgets

DESCRIPTION="paraver gui"
HOMEPAGE="
	http://tools.bsc.es/paraver
	https://github.com/bsc-performance-tools/wxparaver
"
SRC_URI="https://github.com/bsc-performance-tools/wxparaver/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="extrae ompss openmp"

RDEPEND="
	dev-libs/boost:=
	dev-libs/openssl
	sys-cluster/paraver-kernel

	extrae? ( sys-cluster/extrae )
"
DEPEND="${RDEPEND}"
BDEPEND="app-admin/chrpath"

DOCS=( README NEWS AUTHORS ChangeLog )

src_unpack() {
	default
	gzip -d "${S}/docs/wxparaver_help_contents/install/man/paraver-toolset.1.gz" || die
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	setup-wxwidgets

	local myconf=(
		--disable-old-pcfparser
		--with-boost="${EPREFIX}/usr"
		--with-boost-libdir="${EPREFIX}/usr/$(get_libdir)"
		--with-debug-level=none
		--with-openssl="${EPREFIX}/usr"
		--with-paraver="${EPREFIX}/usr"

		$(use_enable ompss)
		$(use_enable openmp)
	)

	if use extrae; then
		myconf+=( "--with-extrae=${EPREFIX}/usr" )
	else
		myconf+=( "--without-extrae" )
	fi

	econf "${myconf[@]}" || die
}

src_compile() {
	default
	docs_compile
}

src_install() {
	# only a part of the docs can be built from source
	if use doc; then
		# remove a part of the prebuilt docs
		rm -r "${S}/docs/wxparaver_help_contents/install/html/2.paraver_toolset" || die
		# replace them with the newly built docs
		mv "${S}/_build/html" "${S}/docs/wxparaver_help_contents/install/html/2.paraver_toolset" || die
		# ideally this is the manpage just built from sphinx but I'm not sure it really is
		doman "${S}/docs/wxparaver_help_contents/sphinx/2.paraver_toolset/build/man/paraver-toolset.1"
	else
		# install the prebuilt manpage
		doman "${S}/docs/wxparaver_help_contents/install/man/paraver-toolset.1"
	fi
	# override eclass variable
	unset HTML_DOCS
	HTML_DOCS=( docs/wxparaver_help_contents/install/html/. )

	default

	rm -r "${ED}/usr/share/doc/wxparaver_help_contents" || die
	chrpath -d "${ED}/usr/bin/wxparaver.bin" || die
#	find "${ED}" -name '*.la' -delete || die
}
