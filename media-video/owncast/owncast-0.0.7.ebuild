# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A self-hosted live video and web chat server"
HOMEPAGE="https://owncast.online/ https://github.com/owncast/owncast"

LICENSE="MIT Apache-2.0 ISC BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/owncast
	acct-group/owncast
	media-video/ffmpeg"

EGO_SUM=(
	"github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d"
	"github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d/go.mod"
	"github.com/amalfra/etag v0.0.0-20190921100247-cafc8de96bc5"
	"github.com/amalfra/etag v0.0.0-20190921100247-cafc8de96bc5/go.mod"
	"github.com/aws/aws-sdk-go v1.38.35"
	"github.com/aws/aws-sdk-go v1.38.35/go.mod"
	"github.com/aymerick/douceur v0.2.0"
	"github.com/aymerick/douceur v0.2.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/go-ole/go-ole v1.2.4"
	"github.com/go-ole/go-ole v1.2.4/go.mod"
	"github.com/gobuffalo/here v0.6.0"
	"github.com/gobuffalo/here v0.6.0/go.mod"
	"github.com/gorilla/css v1.0.0"
	"github.com/gorilla/css v1.0.0/go.mod"
	"github.com/grafov/m3u8 v0.11.1"
	"github.com/grafov/m3u8 v0.11.1/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/markbates/pkger v0.17.1"
	"github.com/markbates/pkger v0.17.1/go.mod"
	"github.com/mattn/go-sqlite3 v1.9.0/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.7"
	"github.com/mattn/go-sqlite3 v1.14.7/go.mod"
	"github.com/microcosm-cc/bluemonday v1.0.9"
	"github.com/microcosm-cc/bluemonday v1.0.9/go.mod"
	"github.com/mssola/user_agent v0.5.2"
	"github.com/mssola/user_agent v0.5.2/go.mod"
	"github.com/mvdan/xurls v1.1.0"
	"github.com/mvdan/xurls v1.1.0/go.mod"
	"github.com/nareix/joy5 v0.0.0-20200712071056-a55089207c88"
	"github.com/nareix/joy5 v0.0.0-20200712071056-a55089207c88/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/oschwald/geoip2-golang v1.5.0"
	"github.com/oschwald/geoip2-golang v1.5.0/go.mod"
	"github.com/oschwald/maxminddb-golang v1.8.0"
	"github.com/oschwald/maxminddb-golang v1.8.0/go.mod"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/schollz/sqlite3dump v1.2.4"
	"github.com/schollz/sqlite3dump v1.2.4/go.mod"
	"github.com/shirou/gopsutil v3.21.4+incompatible"
	"github.com/shirou/gopsutil v3.21.4+incompatible/go.mod"
	"github.com/sirupsen/logrus v1.8.1"
	"github.com/sirupsen/logrus v1.8.1/go.mod"
	"github.com/spf13/cobra v0.0.4-0.20190109003409-7547e83b2d85/go.mod"
	"github.com/spf13/pflag v1.0.4-0.20181223182923-24fa6976df40/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/teris-io/shortid v0.0.0-20171029131806-771a37caa5cf"
	"github.com/teris-io/shortid v0.0.0-20171029131806-771a37caa5cf/go.mod"
	"github.com/tklauser/go-sysconf v0.3.5"
	"github.com/tklauser/go-sysconf v0.3.5/go.mod"
	"github.com/tklauser/numcpus v0.2.2"
	"github.com/tklauser/numcpus v0.2.2/go.mod"
	"github.com/yuin/goldmark v1.3.5"
	"github.com/yuin/goldmark v1.3.5/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/mod v0.4.2"
	"golang.org/x/mod v0.4.2/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190522155817-f3200d17e092/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod"
	"golang.org/x/net v0.0.0-20210421230115-4e50805a0758"
	"golang.org/x/net v0.0.0-20210421230115-4e50805a0758/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20191224085550-c709ea063b76/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210316164454-77fc1eacc6aa/go.mod"
	"golang.org/x/sys v0.0.0-20210420072515-93ed5bcd2bfe"
	"golang.org/x/sys v0.0.0-20210420072515-93ed5bcd2bfe/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/time v0.0.0-20201208040808-7e3f01d25324"
	"golang.org/x/time v0.0.0-20201208040808-7e3f01d25324/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.7/go.mod"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"mvdan.cc/xurls v1.1.0"
	"mvdan.cc/xurls v1.1.0/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/owncast/owncast/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/owncast/owncast/releases/download/v${PV}/${P}-linux-64bit.zip
	${EGO_SUM_SRC_URI}"

src_unpack() {
	go-module_src_unpack

	# go-module_src_unpack unpacked both the source and the binary
	# package. This places the binary package files in the wrong
	# place, but that's hopefully survivable. We need the binary
	# package to get the minified CSS file, which is generated using
	# NPM by upstream.
	cp "${WORKDIR}"/webroot/js/web_modules/tailwindcss/dist/tailwind.min.css "${S}"/webroot/js/web_modules/tailwindcss/dist/tailwind.min.css || die
}

src_compile() {
	go build -v -work -x -ldflags \
	   "-s -w -X main.BuildVersion=${PV} -X main.BuildPlatform=gentoo" \
	   -o ${PN} \
	   github.com/${PN}/${PN} || die
}

src_install() {
	dobin ${PN}

	dodoc README.md

	newinitd "${FILESDIR}"/${PN}.initd ${PN}

	diropts -m 0755 -o owncast -g owncast
	insopts -m 0644 -o owncast -g owncast

	insinto /var/lib/${PN}
	doins -r static webroot
}

pkg_postinst() {
	go-module_pkg_postinst

	if [[ -z "${REPLACING_VERSIONS}" ]] ; then
		einfo "The admin interface at http://localhost:8080/admin/"
		einfo "has default username 'admin' and password 'abc123'."
		einfo "The default stream key is 'abc123'."
	fi

	einfo "Hardware accelerated transcoding requires support in media-video/ffmpeg, see ${HOMEPAGE}/docs/codecs/"
}
