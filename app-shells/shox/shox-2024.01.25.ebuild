# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A customisable, universally compatible terminal status bar"
HOMEPAGE="https://github.com/liamg/shox"
# 2024.01.25
SHA="6a0506aebcafcd598fbcd824be9c5f0608836ab1"
SRC_URI="https://github.com/liamg/shox/archive/${SHA}.tar.gz"

EGO_SUM=(
	"github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d"
	"github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d/go.mod"
	"github.com/creack/pty v1.1.11"
	"github.com/creack/pty v1.1.11/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/distatus/battery v0.10.0"
	"github.com/distatus/battery v0.10.0/go.mod"
	"github.com/go-ole/go-ole v1.2.4"
	"github.com/go-ole/go-ole v1.2.4/go.mod"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/mattn/go-runewidth v0.0.8"
	"github.com/mattn/go-runewidth v0.0.8/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/shirou/gopsutil v2.20.1+incompatible"
	"github.com/shirou/gopsutil v2.20.1+incompatible/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.5.1"
	"github.com/stretchr/testify v1.5.1/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.1.0"
	"golang.org/x/crypto v0.1.0/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.1.0/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190912141932-bc967efca4b8/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.1.0"
	"golang.org/x/sys v0.1.0/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.1.0"
	"golang.org/x/term v0.1.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.4.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/yaml.v2 v2.2.1/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.8"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"howett.net/plist v0.0.0-20181124034731-591f970eefbb"
	"howett.net/plist v0.0.0-20181124034731-591f970eefbb/go.mod"
	)
go-module_set_globals

SRC_URI+=" ${EGO_SUM_SRC_URI}"

S="${WORKDIR}/${PN}-${SHA}"

LICENSE="Apache-2.0 BSD-2 BSD MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default

	rm -rf ./vendor

    # shox fails to build when the go version in its go.mod is go 1.15. It needs to be at least 1.17.
	sed -ie "s/go 1.15/go 1.17/" ./go.mod || die "Fails applying go version patch."
}

src_compile() {
    # If the current EGO_SUM is removed, this command will fail complaining about inconsitency.
    # It will then ask for running "ego mod vendor", which will also fail because it will try downloading dependencies.
	ego mod tidy
    # This command succeeds with EGO_SUM but will fail without it.
	ego build ./cmd/shox
    # If the current EGO_SUM is removed, this command will fail.
	#ego build -mod=vendor ./cmd/shox
}

src_test() {
	ego test ...
}

src_install() {
	dobin "${S}/shox"
}
