# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="Command line downloader for the Gemini protocol"
HOMEPAGE="https://github.com/makeworld-the-better-one/gemget"

EGO_SUM=(
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dustin/go-humanize v1.0.0"
	"github.com/dustin/go-humanize v1.0.0/go.mod"
	"github.com/google/go-cmp v0.3.1"
	"github.com/google/go-cmp v0.3.1/go.mod"
	"github.com/k0kubun/go-ansi v0.0.0-20180517002512-3bf9e2903213/go.mod"
	"github.com/makeworld-the-better-one/go-gemini v0.11.0"
	"github.com/makeworld-the-better-one/go-gemini v0.11.0/go.mod"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mitchellh/colorstring v0.0.0-20190213212951-d06e56a500db"
	"github.com/mitchellh/colorstring v0.0.0-20190213212951-d06e56a500db/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/schollz/progressbar/v3 v3.6.0"
	"github.com/schollz/progressbar/v3 v3.6.0/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"golang.org/x/net v0.0.0-20201216054612-986b41b23924"
	"golang.org/x/net v0.0.0-20201216054612-986b41b23924/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200615200032-f1bc736245b1/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.3"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	)
go-module_set_globals
SRC_URI="https://github.com/makeworld-the-better-one/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="0BSD BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_compile() {
	go build -o ${PN} -ldflags="-s -w" || die
}

src_install() {
	dobin ${PN}
	dodoc README.md
}
