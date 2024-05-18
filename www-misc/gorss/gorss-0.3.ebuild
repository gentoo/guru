# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_PN="github.com/Lallassu/gorss"
EGO_SUM=(
	"github.com/DATA-DOG/go-sqlmock v1.3.3/go.mod"
	"github.com/OpenPeeDeeP/xdg v0.2.0"
	"github.com/OpenPeeDeeP/xdg v0.2.0/go.mod"
	"github.com/PuerkitoBio/goquery v1.5.0"
	"github.com/PuerkitoBio/goquery v1.5.0/go.mod"
	"github.com/andybalholm/cascadia v1.0.0"
	"github.com/andybalholm/cascadia v1.0.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/gdamore/encoding v1.0.0"
	"github.com/gdamore/encoding v1.0.0/go.mod"
	"github.com/gdamore/tcell v1.1.2/go.mod"
	"github.com/gdamore/tcell v1.2.0"
	"github.com/gdamore/tcell v1.2.0/go.mod"
	"github.com/gilliek/go-opml v1.0.0"
	"github.com/gilliek/go-opml v1.0.0/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.0.2"
	"github.com/lucasb-eyer/go-colorful v1.0.2/go.mod"
	"github.com/mattn/go-runewidth v0.0.4"
	"github.com/mattn/go-runewidth v0.0.4/go.mod"
	"github.com/mattn/go-sqlite3 v1.11.0"
	"github.com/mattn/go-sqlite3 v1.11.0/go.mod"
	"github.com/mmcdole/gofeed v1.0.0-beta2"
	"github.com/mmcdole/gofeed v1.0.0-beta2/go.mod"
	"github.com/mmcdole/goxpp v0.0.0-20181012175147-0068e33feabf"
	"github.com/mmcdole/goxpp v0.0.0-20181012175147-0068e33feabf/go.mod"
	"github.com/olekukonko/tablewriter v0.0.1"
	"github.com/olekukonko/tablewriter v0.0.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/tview v0.0.0-20190829161255-f8bc69b90341"
	"github.com/rivo/tview v0.0.0-20190829161255-f8bc69b90341/go.mod"
	"github.com/rivo/uniseg v0.0.0-20190513083848-b9f5b9457d44"
	"github.com/rivo/uniseg v0.0.0-20190513083848-b9f5b9457d44/go.mod"
	"github.com/ssor/bom v0.0.0-20170718123548-6386211fdfcf"
	"github.com/ssor/bom v0.0.0-20170718123548-6386211fdfcf/go.mod"
	"github.com/stretchr/objx v0.1.1/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/net v0.0.0-20180218175443-cbe0f9307d01/go.mod"
	"golang.org/x/net v0.0.0-20181114220301-adae6a3d119a/go.mod"
	"golang.org/x/net v0.0.0-20190827160401-ba9fcec4b297"
	"golang.org/x/net v0.0.0-20190827160401-ba9fcec4b297/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190626150813-e07cf5db2756"
	"golang.org/x/sys v0.0.0-20190626150813-e07cf5db2756/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"jaytaylor.com/html2text v0.0.0-20190408195923-01ec452cbe43"
	"jaytaylor.com/html2text v0.0.0-20190408195923-01ec452cbe43/go.mod"
)

go-module_set_globals
DESCRIPTION="Go Terminal Feed Reader"
HOMEPAGE="https://github.com/Lallassu/gorss"
SRC_URI="
	https://github.com/Lallassu/gorss/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	# override default behavior to get VERSION from ${PV}
	make VERSION=v"${PV}" build
}

src_install() {
	dobin "${PN}"
	dodoc README.md
}
