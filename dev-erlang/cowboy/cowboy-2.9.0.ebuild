# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rebar

DESCRIPTION="Small, fast, modern HTTP server for Erlang/OTP."
HOMEPAGE="https://github.com/ninenines/cowboy"
SRC_URI="https://github.com/ninenines/${PN}/archive/${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="dev-erlang/cowlib"
RDEPEND="${DEPEND}
	=dev-erlang/ranch-1.7.1*
"

DOCS=( README.asciidoc )

# TODO: cowboy has a test suite with lots of dependencies; enable it once those
# dependencies are merged as well
RESTRICT=test

# Override rebar's default since cowboy doesn't have cowboy.app.src but still
# needs its deps removed
src_prepare() {
	default
	rebar_remove_deps
}
