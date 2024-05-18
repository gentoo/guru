# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/Songmu/gitconfig v0.1.0"
	"github.com/Songmu/gitconfig v0.1.0/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/daviddengcn/go-colortext v1.0.0"
	"github.com/daviddengcn/go-colortext v1.0.0/go.mod"
	"github.com/fatih/color v1.7.0/go.mod"
	"github.com/fatih/color v1.9.0"
	"github.com/fatih/color v1.9.0/go.mod"
	"github.com/go-playground/locales v0.13.0"
	"github.com/go-playground/locales v0.13.0/go.mod"
	"github.com/go-playground/universal-translator v0.17.0"
	"github.com/go-playground/universal-translator v0.17.0/go.mod"
	"github.com/goccy/go-yaml v1.8.0"
	"github.com/goccy/go-yaml v1.8.0/go.mod"
	"github.com/golangplus/bytes v0.0.0-20160111154220-45c989fe5450/go.mod"
	"github.com/golangplus/bytes v1.0.0"
	"github.com/golangplus/bytes v1.0.0/go.mod"
	"github.com/golangplus/fmt v1.0.0"
	"github.com/golangplus/fmt v1.0.0/go.mod"
	"github.com/golangplus/testing v1.0.0"
	"github.com/golangplus/testing v1.0.0/go.mod"
	"github.com/leodido/go-urn v1.2.0"
	"github.com/leodido/go-urn v1.2.0/go.mod"
	"github.com/mattn/go-colorable v0.1.4/go.mod"
	"github.com/mattn/go-colorable v0.1.7"
	"github.com/mattn/go-colorable v0.1.7/go.mod"
	"github.com/mattn/go-isatty v0.0.8/go.mod"
	"github.com/mattn/go-isatty v0.0.10/go.mod"
	"github.com/mattn/go-isatty v0.0.11/go.mod"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/motemen/go-colorine v0.0.0-20180816141035-45d19169413a"
	"github.com/motemen/go-colorine v0.0.0-20180816141035-45d19169413a/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.0.1"
	"github.com/russross/blackfriday/v2 v2.0.1/go.mod"
	"github.com/saracen/walker v0.1.1"
	"github.com/saracen/walker v0.1.1/go.mod"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.4.0"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/urfave/cli/v2 v2.2.0"
	"github.com/urfave/cli/v2 v2.2.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20200707034311-ab3426394381"
	"golang.org/x/net v0.0.0-20200707034311-ab3426394381/go.mod"
	"golang.org/x/sync v0.0.0-20200317015054-43a5402ce75a/go.mod"
	"golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208"
	"golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20191008105621-543471e840be/go.mod"
	"golang.org/x/sys v0.0.0-20191010194322-b09406accb47/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20200323222414-85ca7c5b95cd/go.mod"
	"golang.org/x/sys v0.0.0-20200722175500-76b94024e4b6"
	"golang.org/x/sys v0.0.0-20200722175500-76b94024e4b6/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/go-playground/assert.v1 v1.2.1"
	"gopkg.in/go-playground/assert.v1 v1.2.1/go.mod"
	"gopkg.in/go-playground/validator.v9 v9.30.0"
	"gopkg.in/go-playground/validator.v9 v9.30.0/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.3.0"
	"gopkg.in/yaml.v2 v2.3.0/go.mod"
)

go-module_set_globals

DESCRIPTION="Remote repository management made easy"
HOMEPAGE="https://github.com/x-motemen/ghq"
SRC_URI="
	https://github.com/x-motemen/ghq/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

src_compile() {
	go build -v -work -x -o ${PN} || die
}

src_install() {
	dobin ${PN}
	einstalldocs
}
