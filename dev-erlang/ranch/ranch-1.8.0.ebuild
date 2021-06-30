# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rebar

DESCRIPTION="Socket acceptor pool for TCP protocols."
HOMEPAGE="https://github.com/ninenines/ranch"
SRC_URI="https://github.com/ninenines/${PN}/archive/${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.asciidoc )

# TODO: ranch has a test suite with lots of dependencies; enable it once those
# dependencies are merged as well
RESTRICT=test

# Override with EAPI default because it's missing ranch.app.src and doesn't
# have any deps.
src_prepare() {
	default
}
