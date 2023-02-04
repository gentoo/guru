# Copyright 2020-2021,2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

# NOTE: Keep EGO_SUM in sync with go.sum (with dev-go/get-ego-vendor).
EGO_SUM=(
	"github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751"
	"github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751/go.mod"
	"github.com/alecthomas/units v0.0.0-20190924025748-f65c72e2690d"
	"github.com/alecthomas/units v0.0.0-20190924025748-f65c72e2690d/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/getantibody/folder v1.0.0"
	"github.com/getantibody/folder v1.0.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.6.1"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200709230013-948cd5f35899"
	"golang.org/x/crypto v0.0.0-20200709230013-948cd5f35899/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208"
	"golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20200625212154-ddb9806d33ae"
	"golang.org/x/sys v0.0.0-20200625212154-ddb9806d33ae/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
)
go-module_set_globals

DESCRIPTION="Fast Zsh plugin manager"
HOMEPAGE="https://getantibody.github.io/"
SRC_URI="
	https://github.com/getantibody/antibody/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-vcs/git"

PATCHES=( "${FILESDIR}/${PN}-6.1.1_remove-failing-tests.patch" )

src_configure() {
	if use test; then
		GOFLAGS="${GOFLAGS/-buildmode=pie/-buildmode=exe}" # bug 893190
	fi
}

src_compile() {
	local -a mygoargs=(
		-ldflags "-X main.version=${PV}"
	)
	ego build "${mygoargs[@]}" || die
}

src_install() {
	dobin antibody
	einstalldocs
}
