# Copyright 1999-2022 Gentoo Authors
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
	"github.com/amalfra/etag v0.0.0-20190921100247-cafc8de96bc5"
	"github.com/amalfra/etag v0.0.0-20190921100247-cafc8de96bc5/go.mod"
	"github.com/aws/aws-sdk-go v1.43.0"
	"github.com/aws/aws-sdk-go v1.43.0/go.mod"
	"github.com/aymerick/douceur v0.2.0"
	"github.com/aymerick/douceur v0.2.0/go.mod"
	"github.com/dave/jennifer v1.3.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/go-fed/httpsig v0.1.1-0.20190914113940-c2de3672e5b5/go.mod"
	"github.com/go-fed/httpsig v1.1.0"
	"github.com/go-fed/httpsig v1.1.0/go.mod"
	"github.com/go-ole/go-ole v1.2.6"
	"github.com/go-ole/go-ole v1.2.6/go.mod"
	"github.com/go-test/deep v1.0.1"
	"github.com/go-test/deep v1.0.1/go.mod"
	"github.com/golang/mock v1.2.0/go.mod"
	"github.com/gorilla/css v1.0.0"
	"github.com/gorilla/css v1.0.0/go.mod"
	"github.com/gorilla/websocket v1.5.0"
	"github.com/gorilla/websocket v1.5.0/go.mod"
	"github.com/grafov/m3u8 v0.11.1"
	"github.com/grafov/m3u8 v0.11.1/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/jonboulle/clockwork v0.2.2"
	"github.com/jonboulle/clockwork v0.2.2/go.mod"
	"github.com/lestrrat-go/envload v0.0.0-20180220234015-a3eb8ddeffcc"
	"github.com/lestrrat-go/envload v0.0.0-20180220234015-a3eb8ddeffcc/go.mod"
	"github.com/lestrrat-go/file-rotatelogs v2.4.0+incompatible"
	"github.com/lestrrat-go/file-rotatelogs v2.4.0+incompatible/go.mod"
	"github.com/lestrrat-go/strftime v1.0.4"
	"github.com/lestrrat-go/strftime v1.0.4/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.7/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.10"
	"github.com/mattn/go-sqlite3 v1.14.10/go.mod"
	"github.com/microcosm-cc/bluemonday v1.0.18"
	"github.com/microcosm-cc/bluemonday v1.0.18/go.mod"
	"github.com/mssola/user_agent v0.5.3"
	"github.com/mssola/user_agent v0.5.3/go.mod"
	"github.com/mvdan/xurls v1.1.0"
	"github.com/mvdan/xurls v1.1.0/go.mod"
	"github.com/nareix/joy5 v0.0.0-20200712071056-a55089207c88"
	"github.com/nareix/joy5 v0.0.0-20200712071056-a55089207c88/go.mod"
	"github.com/oschwald/geoip2-golang v1.6.1"
	"github.com/oschwald/geoip2-golang v1.6.1/go.mod"
	"github.com/oschwald/maxminddb-golang v1.8.0"
	"github.com/oschwald/maxminddb-golang v1.8.0/go.mod"
	"github.com/owncast/activity v1.0.1-0.20211229051252-7821289d4026"
	"github.com/owncast/activity v1.0.1-0.20211229051252-7821289d4026/go.mod"
	"github.com/pkg/errors v0.8.1/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rifflock/lfshook v0.0.0-20180920164130-b9218ef580f5"
	"github.com/rifflock/lfshook v0.0.0-20180920164130-b9218ef580f5/go.mod"
	"github.com/schollz/sqlite3dump v1.3.1"
	"github.com/schollz/sqlite3dump v1.3.1/go.mod"
	"github.com/shirou/gopsutil v3.21.11+incompatible"
	"github.com/shirou/gopsutil v3.21.11+incompatible/go.mod"
	"github.com/sirupsen/logrus v1.8.1"
	"github.com/sirupsen/logrus v1.8.1/go.mod"
	"github.com/spf13/cobra v0.0.4-0.20190109003409-7547e83b2d85/go.mod"
	"github.com/spf13/pflag v1.0.4-0.20181223182923-24fa6976df40/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/teris-io/shortid v0.0.0-20171029131806-771a37caa5cf"
	"github.com/teris-io/shortid v0.0.0-20171029131806-771a37caa5cf/go.mod"
	"github.com/tklauser/go-sysconf v0.3.5"
	"github.com/tklauser/go-sysconf v0.3.5/go.mod"
	"github.com/tklauser/numcpus v0.2.2"
	"github.com/tklauser/numcpus v0.2.2/go.mod"
	"github.com/yuin/goldmark v1.4.7"
	"github.com/yuin/goldmark v1.4.7/go.mod"
	"github.com/yusufpapurcu/wmi v1.2.2"
	"github.com/yusufpapurcu/wmi v1.2.2/go.mod"
	"golang.org/x/crypto v0.0.0-20180527072434-ab813273cd59/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/mod v0.5.1"
	"golang.org/x/mod v0.5.1/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190522155817-f3200d17e092/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20210614182718-04defd469f4e/go.mod"
	"golang.org/x/net v0.0.0-20211216030914-fe4d6282115f"
	"golang.org/x/net v0.0.0-20211216030914-fe4d6282115f/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sys v0.0.0-20180525142821-c11f84a56e43/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190916202348-b4ddaad3f8a3/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20191224085550-c709ea063b76/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210316164454-77fc1eacc6aa/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210514084401-e8d321eab015"
	"golang.org/x/sys v0.0.0-20210514084401-e8d321eab015/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.6"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/time v0.0.0-20201208040808-7e3f01d25324"
	"golang.org/x/time v0.0.0-20201208040808-7e3f01d25324/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
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
	go build -v -work -x \
	   -ldflags "-s -w -X github.com/${PN}/${PN}/config.VersionNumber=${PV} -X github.com/${PN}/${PN}/config.BuildPlatform=gentoo" \
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
	fi

	einfo "Hardware accelerated transcoding requires support in media-video/ffmpeg, see https://owncast.online/docs/codecs/"
}
