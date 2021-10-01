# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module node

EGO_SUM=(
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/fsnotify/fsnotify v1.4.7/go.mod"
	"github.com/golang/protobuf v1.2.0/go.mod"
	"github.com/golang/protobuf v1.5.0/go.mod"
	"github.com/golang/snappy v0.0.0-20180518054509-2e65f85255db"
	"github.com/golang/snappy v0.0.0-20180518054509-2e65f85255db/go.mod"
	"github.com/google/go-cmp v0.5.5/go.mod"
	"github.com/hpcloud/tail v1.0.0/go.mod"
	"github.com/onsi/ginkgo v1.6.0/go.mod"
	"github.com/onsi/ginkgo v1.7.0/go.mod"
	"github.com/onsi/gomega v1.4.3/go.mod"
	"github.com/paulmach/go.geo v0.0.0-20180829195134-22b514266d33"
	"github.com/paulmach/go.geo v0.0.0-20180829195134-22b514266d33/go.mod"
	"github.com/paulmach/go.geojson v1.4.0"
	"github.com/paulmach/go.geojson v1.4.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/qedus/osmpbf v1.2.0"
	"github.com/qedus/osmpbf v1.2.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/syndtr/goleveldb v1.0.0"
	"github.com/syndtr/goleveldb v1.0.0/go.mod"
	"github.com/tmthrgd/go-popcount v0.0.0-20190904054823-afb1ace8b04f"
	"github.com/tmthrgd/go-popcount v0.0.0-20190904054823-afb1ace8b04f/go.mod"
	"golang.org/x/net v0.0.0-20180906233101-161cd47e91fd/go.mod"
	"golang.org/x/sync v0.0.0-20180314180146-1d60e4601c6f/go.mod"
	"golang.org/x/sys v0.0.0-20180909124046-d0be0721c37e/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"google.golang.org/protobuf v1.26.0-rc.1/go.mod"
	"google.golang.org/protobuf v1.26.0"
	"google.golang.org/protobuf v1.26.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/fsnotify.v1 v1.4.7/go.mod"
	"gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7/go.mod"
	"gopkg.in/yaml.v2 v2.2.1/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
)
go-module_set_globals

DESCRIPTION="Golang osm pbf parser with npm wrapper"
HOMEPAGE="
	https://github.com/pelias/pbf2json
	https://www.npmjs.com/package/pbf2json
"
SRC_URI="
	https://github.com/pelias/pbf2json/archive/refs/tags/v${PV}.tar.gz -> ${P}.tgz
	${EGO_SUM_SRC_URI}
"
S="${WORKDIR}/${P}"

LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/split
	dev-js/through2
"

src_unpack() {
	node_src_unpack
	go-module_setup_proxy
}

src_prepare() {
	rm -r build/* || die
	node_src_prepare
}

src_compile() {
	go build -v -x || die

	chmod +x pbf2json || die

	platform=$(node -p "var os=require('os'); os.platform()") || die
	arch=$(node -p "var os=require('os'); os.arch()") || die

	mv pbf2json "build/pbf2json.${platform}-${arch}" || die

	node_src_compile
}
