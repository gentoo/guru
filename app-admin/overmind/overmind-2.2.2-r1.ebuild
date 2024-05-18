# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/DarthSim/godotenv v1.3.1"
	"github.com/DarthSim/godotenv v1.3.1/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d/go.mod"
	"github.com/kardianos/osext v0.0.0-20190222173326-2bc1f35cddc0"
	"github.com/kardianos/osext v0.0.0-20190222173326-2bc1f35cddc0/go.mod"
	"github.com/matoous/go-nanoid v0.0.0-20181114085210-eab626deece6"
	"github.com/matoous/go-nanoid v0.0.0-20181114085210-eab626deece6/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.0.1"
	"github.com/russross/blackfriday/v2 v2.0.1/go.mod"
	"github.com/sevlyar/go-daemon v0.1.5"
	"github.com/sevlyar/go-daemon v0.1.5/go.mod"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod"
	"github.com/urfave/cli v1.22.2"
	"github.com/urfave/cli v1.22.2/go.mod"
	"golang.org/x/crypto v0.0.0-20190411191339-88737f569e3a"
	"golang.org/x/crypto v0.0.0-20190411191339-88737f569e3a/go.mod"
	"golang.org/x/sys v0.0.0-20190403152447-81d4e9dc473e"
	"golang.org/x/sys v0.0.0-20190403152447-81d4e9dc473e/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	)
go-module_set_globals

DESCRIPTION="Process manager for Procfile-based applications and tmux"
HOMEPAGE="https://github.com/DarthSim/overmind"
SRC_URI="https://github.com/DarthSim/overmind/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT BSD BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-misc/tmux"

src_compile() {
	go build -ldflags "-s -w" || die "go build failed"
}

src_install() {
	dobin "${PN}"
	dodoc README.md
}
