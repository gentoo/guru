# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module golang-build

EGO_SUM=(
"github.com/gdamore/encoding v1.0.0"
"github.com/gdamore/encoding v1.0.0/go.mod"
"github.com/gdamore/tcell/v2 v2.0.0"
"github.com/gdamore/tcell/v2 v2.0.0/go.mod"
"github.com/lucasb-eyer/go-colorful v1.0.3"
"github.com/lucasb-eyer/go-colorful v1.0.3/go.mod"
"github.com/mattn/go-runewidth v0.0.7/go.mod"
"github.com/mattn/go-runewidth v0.0.9"
"github.com/mattn/go-runewidth v0.0.9/go.mod"
"golang.org/x/sys v0.0.0-20190626150813-e07cf5db2756"
"golang.org/x/sys v0.0.0-20190626150813-e07cf5db2756/go.mod"
"golang.org/x/text v0.3.0"
"golang.org/x/text v0.3.0/go.mod"
"gopkg.in/djherbis/times.v1 v1.2.0"
"gopkg.in/djherbis/times.v1 v1.2.0/go.mod"
	)

go-module_set_globals

DESCRIPTION="Terminal file manager"
HOMEPAGE="https://github.com/gokcehan/lf"
SRC_URI="https://github.com/gokcehan/lf/archive/r20.tar.gz -> ${PN}-r${PV}.tar.gz
		${EGO_SUM_SRC_URI}"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/lf-r${PV}"

EGO_PN=github.com/gokcehan/lf

src_compile() {
	go build
}

src_install() {
	dobin "lf"
}
