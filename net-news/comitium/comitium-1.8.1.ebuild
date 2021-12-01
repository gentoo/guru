# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"git.mills.io/prologic/go-gopher v0.0.0-20210723054659-c5e856b800b8"
	"git.mills.io/prologic/go-gopher v0.0.0-20210723054659-c5e856b800b8/go.mod"
	"git.sr.ht/~adnano/go-gemini v0.1.17"
	"git.sr.ht/~adnano/go-gemini v0.1.17/go.mod"
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/PuerkitoBio/goquery v1.5.1"
	"github.com/PuerkitoBio/goquery v1.5.1/go.mod"
	"github.com/andybalholm/cascadia v1.1.0"
	"github.com/andybalholm/cascadia v1.1.0/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/google/gofuzz v1.0.0/go.mod"
	"github.com/json-iterator/go v1.1.10"
	"github.com/json-iterator/go v1.1.10/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/mmcdole/gofeed v1.1.0"
	"github.com/mmcdole/gofeed v1.1.0/go.mod"
	"github.com/mmcdole/goxpp v0.0.0-20181012175147-0068e33feabf"
	"github.com/mmcdole/goxpp v0.0.0-20181012175147-0068e33feabf/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421"
	"github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421/go.mod"
	"github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742"
	"github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.0.1/go.mod"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/urfave/cli v1.22.3/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/net v0.0.0-20180218175443-cbe0f9307d01/go.mod"
	"golang.org/x/net v0.0.0-20181220203305-927f97764cc3/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/net v0.0.0-20200301022130-244492dfa37a/go.mod"
	"golang.org/x/net v0.0.0-20210119194325-5f4716e94777"
	"golang.org/x/net v0.0.0-20210119194325-5f4716e94777/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
)

go-module_set_globals

DESCRIPTION="feed aggregator for gemini supporting many formats and protocols"
HOMEPAGE="https://git.nytpu.com/comitium/about/"
SRC_URI="https://git.nytpu.com/comitium/snapshot/${P}.tar.bz2
	${EGO_SUM_SRC_URI}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-text/scdoc"

DOCS=( doc/quickstart.{en,fr}.md doc/translating.en.md )

src_compile() {
	emake COMMIT=tarball
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
