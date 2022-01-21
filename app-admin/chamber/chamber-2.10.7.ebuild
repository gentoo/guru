# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/aws/aws-sdk-go v1.38.22"
	"github.com/aws/aws-sdk-go v1.38.22/go.mod"
	"github.com/bmizerany/assert v0.0.0-20160611221934-b7ed37b82869"
	"github.com/bmizerany/assert v0.0.0-20160611221934-b7ed37b82869/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/inconshreveable/mousetrap v1.0.0/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/magiconair/properties v1.8.0"
	"github.com/magiconair/properties v1.8.0/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/segmentio/backo-go v0.0.0-20160424052352-204274ad699c"
	"github.com/segmentio/backo-go v0.0.0-20160424052352-204274ad699c/go.mod"
	"github.com/spf13/cobra v0.0.3"
	"github.com/spf13/cobra v0.0.3/go.mod"
	"github.com/spf13/pflag v1.0.2"
	"github.com/spf13/pflag v1.0.2/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/xtgo/uuid v0.0.0-20140804021211-a0b114877d4c"
	"github.com/xtgo/uuid v0.0.0-20140804021211-a0b114877d4c/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b"
	"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/segmentio/analytics-go.v3 v3.0.1"
	"gopkg.in/segmentio/analytics-go.v3 v3.0.1/go.mod"
	"gopkg.in/yaml.v2 v2.2.8"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200506231410-2ff61e1afc86"
	"gopkg.in/yaml.v3 v3.0.0-20200506231410-2ff61e1afc86/go.mod"
	)
go-module_set_globals

DESCRIPTION="Managing secrets in AWS SSM Parameter Store"
HOMEPAGE="https://github.com/segmentio/chamber"
SRC_URI="https://github.com/segmentio/chamber/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	go build -ldflags "-s -w" || die "go build failed"
}

src_install() {
	dobin "${PN}"
	dodoc README.md CHANGELOG.md
}
