# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# pypy3: obtaining PYTHON_CONFIG not supported
PYTHON_COMPAT=( python3_{10..11} )

inherit autotools python-single-r1

DESCRIPTION="A command-line tool and library to read and convert trace files"
HOMEPAGE="https://babeltrace.org"
SRC_URI="https://www.efficios.com/files/babeltrace/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc man python test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/glib:2
	dev-libs/elfutils

	python? (
		${PYTHON_DEPS}
		virtual/libcrypt
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
	doc? (
		app-text/doxygen
		python? ( dev-python/sphinx )
	)
	man? (
		app-text/asciidoc
		app-text/xmlto
	)
	python? ( dev-lang/swig )
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use debug && export BABELTRACE_DEBUG_MODE=1

	local myconf=(
		--disable-built-in-plugins
		--disable-built-in-python-plugin-support
		--disable-compile-warnings
		--disable-static
		--enable-debug-info
		--enable-shared

		$(use_enable doc api-doc)
		$(use_enable man man-pages)
		$(use_enable python python-bindings)
		$(use_enable python python-plugins)
		$(use_enable test glibtest)
	)

	if use python; then
		export PYTHON_CONFIG="$(python_get_PYTHON_CONFIG)"
		myconf+=( "--with-python_prefix=$(python_get_sitedir)" )
		use doc && myconf+=( "--enable-python-bindings-doc" )
	fi

	econf "${myconf[@]}"
}

src_install() {
	default
	use doc && docompress -x "${ED}/usr/doc/${PF}/api"
	find "${D}" -name '*.la' -delete || die
}
