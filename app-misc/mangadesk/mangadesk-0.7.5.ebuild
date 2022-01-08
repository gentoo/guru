# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/darylhjd/mangodex v0.0.0-20211231093527-e4a91c518fa0"
	"github.com/darylhjd/mangodex v0.0.0-20211231093527-e4a91c518fa0/go.mod"
	"github.com/gdamore/encoding v1.0.0"
	"github.com/gdamore/encoding v1.0.0/go.mod"
	"github.com/gdamore/tcell/v2 v2.4.1-0.20210905002822-f057f0a857a1"
	"github.com/gdamore/tcell/v2 v2.4.1-0.20210905002822-f057f0a857a1/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/mattn/go-runewidth v0.0.13"
	"github.com/mattn/go-runewidth v0.0.13/go.mod"
	"github.com/rivo/tview v0.0.0-20211202162923-2a6de950f73b"
	"github.com/rivo/tview v0.0.0-20211202162923-2a6de950f73b/go.mod"
	"github.com/rivo/uniseg v0.2.0"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210309074719-68d13333faf2/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20211216021012-1d35b9e2eb4e"
	"golang.org/x/sys v0.0.0-20211216021012-1d35b9e2eb4e/go.mod"
	"golang.org/x/term v0.0.0-20201210144234-2321bbc49cbf/go.mod"
	"golang.org/x/term v0.0.0-20210220032956-6a3ed077a48d/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
)
go-module_set_globals

DESCRIPTION="Terminal Client for MangaDex"
HOMEPAGE="https://github.com/darylhjd/mangadesk"
SRC_URI="https://github.com/darylhjd/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	go build
}

src_install() {
	dobin ${PN}
	einstalldocs
}
