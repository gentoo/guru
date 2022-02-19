# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_PN="github.com/schachmat/wego"
EGO_SUM=(
	"github.com/mattn/go-colorable v0.1.12"
	"github.com/mattn/go-colorable v0.1.12/go.mod"
	"github.com/mattn/go-isatty v0.0.14"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/mattn/go-runewidth v0.0.13"
	"github.com/mattn/go-runewidth v0.0.13/go.mod"
	"github.com/rivo/uniseg v0.2.0"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/schachmat/ingo v0.0.0-20170403011506-a4bdc0729a3f"
	"github.com/schachmat/ingo v0.0.0-20170403011506-a4bdc0729a3f/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6/go.mod"
	)
go-module_set_globals

DESCRIPTION="Wego is a weather client for the terminal"
SRC_URI="
	https://github.com/schachmat/wego/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"
HOMEPAGE="https://github.com/schachmat/wego"
LICENSE="BSD ISC MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	go build -v -x -o wego || die
}

src_install() {
	dobin wego
	dodoc README.md
}
