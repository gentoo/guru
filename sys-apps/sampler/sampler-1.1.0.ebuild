# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="visualizer for shell commands, executions and alerting"
HOMEPAGE="https://sampler.dev"

EGO_SUM=(
	"github.com/cjbassi/drawille-go v0.0.0-20190126131713-27dc511fe6fd"
	"github.com/cjbassi/drawille-go v0.0.0-20190126131713-27dc511fe6fd/go.mod"
	"github.com/gizak/termui/v3 v3.0.0"
	"github.com/gizak/termui/v3 v3.0.0/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20180628210949-0892b62f0d9f"
	"github.com/gopherjs/gopherjs v0.0.0-20180628210949-0892b62f0d9f/go.mod"
	"github.com/gopherjs/gopherwasm v0.1.1"
	"github.com/gopherjs/gopherwasm v0.1.1/go.mod"
	"github.com/hajimehoshi/go-mp3 v0.1.1"
	"github.com/hajimehoshi/go-mp3 v0.1.1/go.mod"
	"github.com/hajimehoshi/oto v0.1.1"
	"github.com/hajimehoshi/oto v0.1.1/go.mod"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/kr/pty v1.1.4"
	"github.com/kr/pty v1.1.4/go.mod"
	"github.com/kr/pty v1.1.5"
	"github.com/kr/pty v1.1.5/go.mod"
	"github.com/lunixbochs/vtclean v1.0.0"
	"github.com/lunixbochs/vtclean v1.0.0/go.mod"
	"github.com/mattn/go-runewidth v0.0.2/go.mod"
	"github.com/mattn/go-runewidth v0.0.4"
	"github.com/mattn/go-runewidth v0.0.4/go.mod"
	"github.com/mbndr/figlet4go v0.0.0-20190224160619-d6cef5b186ea"
	"github.com/mbndr/figlet4go v0.0.0-20190224160619-d6cef5b186ea/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/mitchellh/go-wordwrap v0.0.0-20150314170334-ad45545899c7/go.mod"
	"github.com/mitchellh/go-wordwrap v1.0.0"
	"github.com/mitchellh/go-wordwrap v1.0.0/go.mod"
	"github.com/nsf/termbox-go v0.0.0-20190121233118-02980233997d"
	"github.com/nsf/termbox-go v0.0.0-20190121233118-02980233997d/go.mod"
	"golang.org/x/arch v0.0.0-20181203225421-5a4828bb7045/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20190502103701-55513cacd4ae/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20190709130402-674ba3eaed22"
	"gopkg.in/yaml.v3 v3.0.0-20190709130402-674ba3eaed22/go.mod"
)
go-module_set_globals
SRC_URI="https://github.com/sqshq/sampler/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT+=" test"

DEPEND+="media-libs/alsa-lib"
RDEPEND+="media-libs/alsa-lib"

src_compile() {
	go build || die
}

src_install() {
	dobin sampler
}
