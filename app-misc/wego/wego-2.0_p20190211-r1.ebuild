# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_COMMIT="994e4f141759a1070d7b0c8fbe5fad2cc7ee7d45"
EGO_PN="github.com/schachmat/wego"
EGO_VENDOR=(
	"github.com/mattn/go-runewidth 43a826dcfbd"
	"github.com/mattn/go-colorable 2e1b0c1546e01"
	"github.com/schachmat/ingo a4bdc0729a3f"
	"github.com/mattn/go-isatty 7b513a986450"
	"github.com/rivo/uniseg f8f8f751c732"
	"golang.org/x/sys d5e6a3e2c0ae github.com/golang/sys"
)

inherit golang-vcs-snapshot golang-build

DESCRIPTION="Wego is a weather client for the terminal"
SRC_URI="
	https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}
"
HOMEPAGE="https://github.com/schachmat/wego"
LICENSE="BSD ISC"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	dobin wego
	dodoc "src/${EGO_PN}/README.md"
}
