# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/shirou/gopsutil/v3 v3.22.3"
	"github.com/shirou/gopsutil/v3 v3.22.3/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"github.com/tklauser/numcpus v0.4.0"
	"github.com/tklauser/numcpus v0.4.0/go.mod"
	"github.com/go-ole/go-ole v1.2.6"
	"github.com/go-ole/go-ole v1.2.6/go.mod"
	"golang.org/x/sys v0.0.0-20190916202348-b4ddaad3f8a3"
	"golang.org/x/sys v0.0.0-20190916202348-b4ddaad3f8a3/go.mod"
	"github.com/google/go-cmp v0.5.7"
	"github.com/google/go-cmp v0.5.7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"github.com/lufia/plan9stats v0.0.0-20211012122336-39d0f177ccd0"
	"github.com/lufia/plan9stats v0.0.0-20211012122336-39d0f177ccd0/go.mod"
	"github.com/google/go-cmp v0.5.6"
	"github.com/google/go-cmp v0.5.6/go.mod"
	"github.com/power-devops/perfstat v0.0.0-20210106213030-5aafc221ea8c"
	"github.com/power-devops/perfstat v0.0.0-20210106213030-5aafc221ea8c/go.mod"
	"golang.org/x/sys v0.0.0-20201204225414-ed752295db88"
	"golang.org/x/sys v0.0.0-20201204225414-ed752295db88/go.mod"
	"github.com/stretchr/testify v1.7.1"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/tklauser/go-sysconf v0.3.10"
	"github.com/tklauser/go-sysconf v0.3.10/go.mod"
	"github.com/yusufpapurcu/wmi v1.2.2"
	"github.com/yusufpapurcu/wmi v1.2.2/go.mod"
	"golang.org/x/sys v0.0.0-20220128215802-99c3d69c2c27"
	"golang.org/x/sys v0.0.0-20220128215802-99c3d69c2c27/go.mod"
	"golang.org/x/term v0.0.0-20201117132131-f5c789dd3221"
	"golang.org/x/term v0.0.0-20201117132131-f5c789dd3221/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/text v0.3.4"
	"golang.org/x/text v0.3.4/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"gopkg.in/ini.v1 v1.66.4"
	"gopkg.in/ini.v1 v1.66.4/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
)

go-module_set_globals

DESCRIPTION="A powerline like prompt for Bash, Zsh, Fish written in Go lang. "
HOMEPAGE="https://github.com/justjanne/powerline-go"
SRC_URI="https://github.com/justjanne/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${EGO_SUM_SRC_URI}"

LICENSE="GPL-3 MIT Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

DOCS=(README.md)

src_compile() {
	go build -o release/powerline-go . || die
}

src_install() {
	dobin release/powerline-go
	einstalldocs
}

pkg_postinst() {
	elog 'Check installed documentation to how-to add this to the shell prompt'
}
