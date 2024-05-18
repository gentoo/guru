# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d"
	"github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d/go.mod"
	"github.com/go-ole/go-ole v1.2.4"
	"github.com/go-ole/go-ole v1.2.4/go.mod"
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/shirou/gopsutil v3.20.12+incompatible"
	"github.com/shirou/gopsutil v3.20.12+incompatible/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20201221181555-eec23a3978ad"
	"golang.org/x/crypto v0.0.0-20201221181555-eec23a3978ad/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20210105210732-16f7687f5001"
	"golang.org/x/sys v0.0.0-20210105210732-16f7687f5001/go.mod"
	"golang.org/x/term v0.0.0-20201117132131-f5c789dd3221"
	"golang.org/x/term v0.0.0-20201117132131-f5c789dd3221/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.4"
	"golang.org/x/text v0.3.4/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
)

go-module_set_globals

DESCRIPTION="A powerline like prompt for Bash, Zsh, Fish written in Go lang. "
HOMEPAGE="https://github.com/justjanne/powerline-go"
SRC_URI="https://github.com/justjanne/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${EGO_SUM_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

DOCS=(README.md)

src_compile() {
	go build -o release/powerline-go . || die
}

src_install() {
	dobin release/powerline-go
	einstalldocs
}

pkg_postinst() {
	elog 'Check installed documentation to how-to add this to the shell prompt'
}
