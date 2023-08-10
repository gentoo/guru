# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d"
	"github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/go-ole/go-ole v1.2.5"
	"github.com/go-ole/go-ole v1.2.5/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/shirou/gopsutil v3.21.1+incompatible"
	"github.com/shirou/gopsutil v3.21.1+incompatible/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"golang.org/x/sys v0.0.0-20190916202348-b4ddaad3f8a3/go.mod"
	"golang.org/x/sys v0.0.0-20220412211240-33da011f77ad"
	"golang.org/x/sys v0.0.0-20220412211240-33da011f77ad/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

SRC_URI="https://github.com/nwg-piotr/gopsuinfo/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
KEYWORDS="~amd64"

DESCRIPTION="A gopsutil-based command to display system usage info as text"
HOMEPAGE="https://github.com/nwg-piotr/gopsuinfo"
LICENSE="MIT"

SLOT="0"

DEPEND=">=dev-lang/go-1.20"

src_compile() {
	emake build
}

src_install() {
	insinto /usr/share/gopsuinfo
	doins -r icons_light
	doins -r icons_dark
	dobin bin/gopsuinfo
}
