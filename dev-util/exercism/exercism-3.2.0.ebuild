# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module bash-completion-r1

DESCRIPTION="Command line client for https://exercism.io"
HOMEPAGE="
	https://exercism.org
	https://github.com/exercism/cli
"
EGO_SUM=(
	"github.com/blang/semver v3.5.1+incompatible"
	"github.com/blang/semver v3.5.1+incompatible/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/fsnotify/fsnotify v1.4.2"
	"github.com/fsnotify/fsnotify v1.4.2/go.mod"
	"github.com/hashicorp/hcl v0.0.0-20170509225359-392dba7d905e"
	"github.com/hashicorp/hcl v0.0.0-20170509225359-392dba7d905e/go.mod"
	"github.com/inconshreveable/go-update v0.0.0-20160112193335-8152e7eb6ccf"
	"github.com/inconshreveable/go-update v0.0.0-20160112193335-8152e7eb6ccf/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/inconshreveable/mousetrap v1.0.0/go.mod"
	"github.com/magiconair/properties v1.7.3"
	"github.com/magiconair/properties v1.7.3/go.mod"
	"github.com/mitchellh/mapstructure v0.0.0-20170523030023-d0303fe80992"
	"github.com/mitchellh/mapstructure v0.0.0-20170523030023-d0303fe80992/go.mod"
	"github.com/pelletier/go-buffruneio v0.2.0"
	"github.com/pelletier/go-buffruneio v0.2.0/go.mod"
	"github.com/pelletier/go-toml v1.0.0"
	"github.com/pelletier/go-toml v1.0.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/spf13/afero v0.0.0-20170217164146-9be650865eab"
	"github.com/spf13/afero v0.0.0-20170217164146-9be650865eab/go.mod"
	"github.com/spf13/cast v1.1.0"
	"github.com/spf13/cast v1.1.0/go.mod"
	"github.com/spf13/cobra v0.0.0-20170731170427-b26b538f6930"
	"github.com/spf13/cobra v0.0.0-20170731170427-b26b538f6930/go.mod"
	"github.com/spf13/jwalterweatherman v0.0.0-20170523133247-0efa5202c046"
	"github.com/spf13/jwalterweatherman v0.0.0-20170523133247-0efa5202c046/go.mod"
	"github.com/spf13/pflag v1.0.0"
	"github.com/spf13/pflag v1.0.0/go.mod"
	"github.com/spf13/viper v0.0.0-20180507071007-15738813a09d"
	"github.com/spf13/viper v0.0.0-20180507071007-15738813a09d/go.mod"
	"github.com/stretchr/testify v1.1.4"
	"github.com/stretchr/testify v1.1.4/go.mod"
	"golang.org/x/net v0.0.0-20170726083632-f5079bd7f6f7"
	"golang.org/x/net v0.0.0-20170726083632-f5079bd7f6f7/go.mod"
	"golang.org/x/sys v0.0.0-20170803140359-d8f5ea21b929"
	"golang.org/x/sys v0.0.0-20170803140359-d8f5ea21b929/go.mod"
	"golang.org/x/sys v0.0.0-20201202213521-69691e467435"
	"golang.org/x/sys v0.0.0-20201202213521-69691e467435/go.mod"
	"golang.org/x/text v0.0.0-20170730040918-3bd178b88a81"
	"golang.org/x/text v0.0.0-20170730040918-3bd178b88a81/go.mod"
	"gopkg.in/yaml.v2 v2.0.0-20170721122051-25c4ec802a7d"
	"gopkg.in/yaml.v2 v2.0.0-20170721122051-25c4ec802a7d/go.mod"
	)
go-module_set_globals

SRC_URI="https://github.com/${PN}/cli/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${EGO_SUM_SRC_URI}
"

LICENSE="MIT Apache-2.0 BSD-2 BSD MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="sys-libs/glibc"
BDEPEND="dev-lang/go"

S="${WORKDIR}/cli-${PV}"

src_compile() {
	ego build -o out/exercism exercism/main.go
}

src_install() {
	default
	dobin out/exercism
	# bash-completion
	newbashcomp "shell/${PN}_completion.bash" "${PN}"
	# zsh-completion
	insinto /usr/share/zsh/site-functions
	newins "shell/${PN}_completion.zsh" "_${PN}"
}
