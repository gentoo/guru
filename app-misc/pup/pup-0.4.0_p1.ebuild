# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/fatih/color v1.0.0"
	"github.com/fatih/color v1.0.0/go.mod"
	"github.com/mattn/go-colorable v0.0.5"
	"github.com/mattn/go-colorable v0.0.5/go.mod"
	"github.com/mattn/go-isatty v0.0.0-20151211000621-56b76bdf51f7"
	"github.com/mattn/go-isatty v0.0.0-20151211000621-56b76bdf51f7/go.mod"
	"golang.org/x/net v0.0.0-20160720084139-4d38db76854b"
	"golang.org/x/net v0.0.0-20160720084139-4d38db76854b/go.mod"
	"golang.org/x/sys v0.0.0-20160717071931-a646d33e2ee3"
	"golang.org/x/sys v0.0.0-20160717071931-a646d33e2ee3/go.mod"
	"golang.org/x/text v0.0.0-20160719205907-0a5a09ee4409"
	"golang.org/x/text v0.0.0-20160719205907-0a5a09ee4409/go.mod"
)

go-module_set_globals

COMMIT="681d7bb639334bf485476f5872c5bdab10931f9a"
DESCRIPTION="Parsing HTML at the command line"
HOMEPAGE="https://github.com/ericchiang/pup"
SRC_URI="https://github.com/ericchiang/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_compile() {
	go build -o ${PN} . || die
}

src_install() {
	dobin ${PN}
}
