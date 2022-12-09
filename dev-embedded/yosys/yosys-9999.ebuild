# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(  python3_{7..9} )

inherit git-r3 python-r1 multilib

DESCRIPTION="RTL synthesis toolkit"
HOMEPAGE="https://yosyshq.net/yosys/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/YosysHQ/yosys.git"
EGIT_BRANCH="master"


LICENSE="ISC"
SLOT="0"
KEYWORDS=""
PROPERTIES="live"
IUSE="+tcl +readline +zlib +abc"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"


BDEPEND="
  sys-devel/gcc[cxx]
  sys-devel/bison
  sys-devel/flex
  sys-apps/gawk
  virtual/pkgconfig
"

RDEPEND="
  dev-libs/libffi
  media-gfx/xdot
  media-gfx/graphviz
  dev-libs/boost[python]
  tcl? ( dev-lang/tcl:= )
  readline? ( sys-libs/readline:= )
  zlib? ( sys-libs/zlib )
  abc? ( sci-mathematics/abc[static-libs] )
"

DEPEND="
  ${PYTHON_DEPS}
  ${RDEPEND}
"


src_configure() {
  emake config-gcc

  echo "ENABLE_TCL := $(usex tcl 1 0)" >> "${S}"/Makefile.conf
  echo "ENABLE_READLINE := $(usex readline 1 0)" >> "${S}"/Makefile.conf
  echo "ENABLE_ZLIB := $(usex zlib 1 0)" >> "${S}"/Makefile.conf
  echo "ENABLE_ABC := $(usex abc 1 0)" >> "${S}"/Makefile.conf
  use abc && echo "ABCEXTERNAL := ${EPREFIX}/usr/bin/abc" >> "${S}"/Makefile.conf
}


src_compile() {
  emake PREFIX="${EPREFIX}/usr"
}


src_install() {
  emake PREFIX="${ED}/usr" install
}
