# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/cli/cli"
EGO_VENDOR=(
	"github.com/AlecAivazis/survey/v2 v2.0.7 github.com/AlecAivazis/survey"
	"github.com/alecthomas/chroma 34d9c7143bf5"
	"github.com/briandowns/spinner v1.9.0"
	"github.com/charmbracelet/glamour 7e5c90143acc"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0 github.com/cpuguy83/go-md2man"
	"github.com/danwakefield/fnmatch cbb64ac3d964"
	"github.com/dlclark/regexp2 v1.2.0"
	"github.com/fatih/color v1.7.0"
	"github.com/google/goterm fc88cf888a3f"
	"github.com/google/shlex e7afc7fbc510"
	"github.com/hashicorp/go-version v1.2.0"
	"github.com/henvic/httpretty v0.0.4"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/kballard/go-shellquote 95032a82bc51"
	"github.com/lucasb-eyer/go-colorful v1.0.3"
	"github.com/mattn/go-colorable v0.1.6"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/mattn/go-runewidth v0.0.8"
	"github.com/mgutz/ansi 9520e82c474b"
	"github.com/microcosm-cc/bluemonday v1.0.2"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/muesli/reflow v0.1.0"
	"github.com/muesli/termenv v0.4.0"
	"github.com/olekukonko/tablewriter v0.0.4"
	"github.com/russross/blackfriday/v2 v2.0.1 github.com/russross/blackfriday"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0"
	"github.com/spf13/cobra v0.0.6"
	"github.com/spf13/pflag v1.0.5"
	"github.com/yuin/goldmark v1.1.24"
	"golang.org/x/crypto 1ad67e1f0ef4 github.com/golang/crypto"
	"golang.org/x/net 46282727080f github.com/golang/net"
	"golang.org/x/sys d5e6a3e2c0ae github.com/golang/sys"
	"golang.org/x/text v0.3.2 github.com/golang/text"
	"gopkg.in/yaml.v2 v2.2.8 github.com/go-yaml/yaml"
	"gopkg.in/yaml.v3 a6ecf24a6d71 github.com/go-yaml/yaml"
)

inherit golang-vcs-snapshot

SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

DESCRIPTION="The official GitHub CLI tool."
HOMEPAGE="https://cli.github.com/"
LICENSE="MIT"

SLOT="0"
IUSE=""
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.13"

QA_PRESTRIPPED="/usr/bin/gh"

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go install -v -work -x -ldflags "\
		-X github.com/cli/cli/command.Version=${PV} \
		-X github.com/cli/cli/command.BuildDate=$(date +%Y-%m-%d) \
		-s -w" \
		${EGO_PN}/cmd/gh || die
}

src_install() {
	dobin bin/*
}
