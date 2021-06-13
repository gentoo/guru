# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 go-module optfeature

EGO_SUM=(
	"github.com/alecthomas/assert v0.0.0-20170929043011-405dbfeb8e38"
	"github.com/alecthomas/assert v0.0.0-20170929043011-405dbfeb8e38/go.mod"
	"github.com/alecthomas/chroma v0.9.1"
	"github.com/alecthomas/chroma v0.9.1/go.mod"
	"github.com/alecthomas/colour v0.0.0-20160524082231-60882d9e2721"
	"github.com/alecthomas/colour v0.0.0-20160524082231-60882d9e2721/go.mod"
	"github.com/alecthomas/kong v0.2.4/go.mod"
	"github.com/alecthomas/repr v0.0.0-20180818092828-117648cd9897"
	"github.com/alecthomas/repr v0.0.0-20180818092828-117648cd9897/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/danwakefield/fnmatch v0.0.0-20160403171240-cbb64ac3d964"
	"github.com/danwakefield/fnmatch v0.0.0-20160403171240-cbb64ac3d964/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dlclark/regexp2 v1.4.0"
	"github.com/dlclark/regexp2 v1.4.0/go.mod"
	"github.com/docopt/docopt-go v0.0.0-20180111231733-ee0de3bc6815"
	"github.com/docopt/docopt-go v0.0.0-20180111231733-ee0de3bc6815/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/mattn/go-colorable v0.1.6/go.mod"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-isatty v0.0.13"
	"github.com/mattn/go-isatty v0.0.13/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/pkg/errors v0.8.1/go.mod"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sergi/go-diff v1.0.0/go.mod"
	"github.com/sergi/go-diff v1.1.0"
	"github.com/sergi/go-diff v1.1.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20200413165638-669c56c373c4/go.mod"
	"golang.org/x/sys v0.0.0-20210608053332-aa57babbf139"
	"golang.org/x/sys v0.0.0-20210608053332-aa57babbf139/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f/go.mod"
	"gopkg.in/yaml.v1 v1.0.0-20140924161607-9f9df34309c0"
	"gopkg.in/yaml.v1 v1.0.0-20140924161607-9f9df34309c0/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.4/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
)

go-module_set_globals

DESCRIPTION="cheat allows you to create and view interactive cheatsheets on the command-line"
HOMEPAGE="https://github.com/cheat/cheat"
SRC_URI="
	https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

# licenses present in the final built
# software. Checked with dev-go/golicense
LICENSE="MIT Apache-2.0 BSD BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="man zsh-completion"

RDEPEND="zsh-completion? ( !app-shells/zsh-completions )"
BDEPEND="man? ( app-text/pandoc )"

src_compile() {
	go build -o ${PN} ./cmd/${PN} || die "compile failed"

	if use man; then
		pandoc -s -t man doc/${PN}.1.md -o doc/${PN}.1 || die "building manpage failed"
	fi
}

src_test() {
	go test ./cmd/${PN} || die
}

src_install() {
	dobin ${PN}

	use man && doman doc/${PN}.1

	newbashcomp scripts/${PN}.bash ${PN}
	insinto /usr/share/fish/vendor_completions.d
	doins scripts/${PN}.fish

	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		newins scripts/${PN}.zsh _cheat
	fi
}

pkg_postinst() {
	optfeature "To enable fzf integration export CHEAT_USE_FZF=true" app-shells/fzf
}
