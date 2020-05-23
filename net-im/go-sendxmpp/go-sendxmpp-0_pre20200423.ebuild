# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_PN="salsa.debian.org/mdosch/go-sendxmpp"
# NOTE: Keep EGO_SUM in sync with go.sum.
EGO_SUM=(
	"github.com/mattn/go-xmpp v0.0.0-20200309091041-899ef71e80d2 h1:F544zRtDc/pMpFNHN46oeXV2jIAG4DoMH+6zlVSn0Q8="
	"github.com/mattn/go-xmpp v0.0.0-20200309091041-899ef71e80d2/go.mod h1:Cs5mF0OsrRRmhkyOod//ldNPOwJsrBvJ+1WRspv0xoc="
	"github.com/pborman/getopt v0.0.0-20190409184431-ee0cd42419d3 h1:YtFkrqsMEj7YqpIhRteVxJxCeC3jJBieuLr0d4C4rSA="
	"github.com/pborman/getopt v0.0.0-20190409184431-ee0cd42419d3/go.mod h1:85jBQOZwpVEaDAr341tbn15RS4fCAsIst0qp7i8ex1o="
)
go-module_set_globals

MY_COMMIT="cbac6dbe8d983d792c8a683c68535bb499896098"

DESCRIPTION="A little tool to send messages to an XMPP contact or MUC"
HOMEPAGE="https://salsa.debian.org/mdosch/go-sendxmpp"
SRC_URI="
	https://salsa.debian.org/mdosch/${PN}/-/archive/${MY_COMMIT}/${PN}-${MY_COMMIT}.tar.bz2 -> ${P}.tar.bz2
	${EGO_SUM_SRC_URI}
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_compile() {
	default

	go build || die
}

src_install() {
	default

	dobin go-sendxmpp
}
