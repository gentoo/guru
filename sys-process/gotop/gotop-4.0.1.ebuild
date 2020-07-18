# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_PN="github.com/xxxserxxx/gotop"
EGO_SUM=(
	"github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d"
	"github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d/go.mod"
	"github.com/VictoriaMetrics/metrics v1.11.2"
	"github.com/VictoriaMetrics/metrics v1.11.2/go.mod"
	"github.com/cjbassi/drawille-go v0.0.0-20190126131713-27dc511fe6fd"
	"github.com/cjbassi/drawille-go v0.0.0-20190126131713-27dc511fe6fd/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/distatus/battery v0.9.0"
	"github.com/distatus/battery v0.9.0/go.mod"
	"github.com/gizak/termui/v3 v3.0.0"
	"github.com/gizak/termui/v3 v3.0.0/go.mod"
	"github.com/gizak/termui/v3 v3.1.0"
	"github.com/gizak/termui/v3 v3.1.0/go.mod"
	"github.com/go-ole/go-ole v1.2.4"
	"github.com/go-ole/go-ole v1.2.4/go.mod"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/mattn/go-runewidth v0.0.2/go.mod"
	"github.com/mattn/go-runewidth v0.0.4"
	"github.com/mattn/go-runewidth v0.0.4/go.mod"
	"github.com/mitchellh/go-wordwrap v0.0.0-20150314170334-ad45545899c7"
	"github.com/mitchellh/go-wordwrap v0.0.0-20150314170334-ad45545899c7/go.mod"
	"github.com/nsf/termbox-go v0.0.0-20190121233118-02980233997d/go.mod"
	"github.com/nsf/termbox-go v0.0.0-20200418040025-38ba6e5628f1"
	"github.com/nsf/termbox-go v0.0.0-20200418040025-38ba6e5628f1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/shibukawa/configdir v0.0.0-20170330084843-e180dbdc8da0"
	"github.com/shibukawa/configdir v0.0.0-20170330084843-e180dbdc8da0/go.mod"
	"github.com/shirou/gopsutil v2.20.3+incompatible"
	"github.com/shirou/gopsutil v2.20.3+incompatible/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.4.0"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/valyala/fastrand v1.0.0"
	"github.com/valyala/fastrand v1.0.0/go.mod"
	"github.com/valyala/histogram v1.0.1"
	"github.com/valyala/histogram v1.0.1/go.mod"
	"github.com/xxxserxxx/opflag v1.0.5"
	"github.com/xxxserxxx/opflag v1.0.5/go.mod"
	"golang.org/x/arch v0.0.0-20181203225421-5a4828bb7045/go.mod"
	"golang.org/x/sys v0.0.0-20200316230553-a7d97aace0b0"
	"golang.org/x/sys v0.0.0-20200316230553-a7d97aace0b0/go.mod"
	"golang.org/x/sys v0.0.0-20200511232937-7e40ca221e25"
	"golang.org/x/sys v0.0.0-20200511232937-7e40ca221e25/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/yaml.v2 v2.2.1/go.mod"
	"gopkg.in/yaml.v2 v2.2.2"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"howett.net/plist v0.0.0-20200419221736-3b63eb3a43b5"
	"howett.net/plist v0.0.0-20200419221736-3b63eb3a43b5/go.mod"
)

go-module_set_globals
DESCRIPTION="A terminal based graphical activity monitor inspired by gtop and vtop"
HOMEPAGE="https://github.com/xxxserxxx/gotop"
SRC_URI="https://github.com/xxxserxxx/gotop/archive/v${PV}.tar.gz -> ${P}.tar.gz
			${EGO_SUM_SRC_URI}"

BDEPEND=">=dev-lang/go-1.13"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	DAT=$(date +%Y%m%dT%H%M%S)
	go build -o gotop \
		-ldflags "-X main.Version=v${PV} -X main.BuildDate=${DAT}" \
		./cmd/gotop
}

src_install() {
	dobin "${PN}"
	dodoc README.md
}
