# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/google/go-cmp v0.2.0/go.mod"
	"github.com/google/licenseclassifier v0.0.0-20201113175434-78a70215ca36"
	"github.com/google/licenseclassifier v0.0.0-20201113175434-78a70215ca36/go.mod"
	"github.com/hashicorp/errwrap v1.0.0"
	"github.com/hashicorp/errwrap v1.0.0/go.mod"
	"github.com/hashicorp/go-multierror v1.1.0"
	"github.com/hashicorp/go-multierror v1.1.0/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.0.3"
	"github.com/lucasb-eyer/go-colorful v1.0.3/go.mod"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/muesli/termenv v0.7.4"
	"github.com/muesli/termenv v0.7.4/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.0.1"
	"github.com/russross/blackfriday/v2 v2.0.1/go.mod"
	"github.com/sergi/go-diff v1.0.0"
	"github.com/sergi/go-diff v1.0.0/go.mod"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/urfave/cli/v2 v2.3.0"
	"github.com/urfave/cli/v2 v2.3.0/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.3/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
)

go-module_set_globals

DESCRIPTION="Go binary license checker"
HOMEPAGE="https://github.com/uw-labs/lichen"
SRC_URI="
	https://github.com/uw-labs/lichen/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="MIT Apache-2.0 BSD BSD-2 MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
RESTRICT="mirror"

src_compile() {
	go build -v -work -x -o ${PN} || die
}

src_install() {
	dobin ${PN}
	einstalldocs
}
