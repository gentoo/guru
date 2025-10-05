# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd toolchain-funcs

EGO_SUM=(
	"filippo.io/edwards25519 v1.1.0"
	"filippo.io/edwards25519 v1.1.0/go.mod"
	"github.com/DATA-DOG/go-sqlmock v1.5.2"
	"github.com/DATA-DOG/go-sqlmock v1.5.2/go.mod"
	"github.com/coder/websocket v1.8.14"
	"github.com/coder/websocket v1.8.14/go.mod"
	"github.com/coreos/go-systemd/v22 v22.5.0"
	"github.com/coreos/go-systemd/v22 v22.5.0/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/emersion/go-vcard v0.0.0-20241024213814-c9703dde27ff"
	"github.com/emersion/go-vcard v0.0.0-20241024213814-c9703dde27ff/go.mod"
	"github.com/godbus/dbus/v5 v5.0.4/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/google/uuid v1.6.0"
	"github.com/google/uuid v1.6.0/go.mod"
	"github.com/kr/pretty v0.2.1/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/lib/pq v1.10.9"
	"github.com/lib/pq v1.10.9/go.mod"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-colorable v0.1.14"
	"github.com/mattn/go-colorable v0.1.14/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.19/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/mattn/go-pointer v0.0.1"
	"github.com/mattn/go-pointer v0.0.1/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.32"
	"github.com/mattn/go-sqlite3 v1.14.32/go.mod"
	"github.com/petermattis/goid v0.0.0-20250904145737-900bdf8bb490"
	"github.com/petermattis/goid v0.0.0-20250904145737-900bdf8bb490/go.mod"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e/go.mod"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rogpeppe/go-internal v1.9.0/go.mod"
	"github.com/rogpeppe/go-internal v1.10.0"
	"github.com/rogpeppe/go-internal v1.10.0/go.mod"
	"github.com/rs/xid v1.6.0"
	"github.com/rs/xid v1.6.0/go.mod"
	"github.com/rs/zerolog v1.34.0"
	"github.com/rs/zerolog v1.34.0/go.mod"
	"github.com/skip2/go-qrcode v0.0.0-20200617195104-da1b6568686e"
	"github.com/skip2/go-qrcode v0.0.0-20200617195104-da1b6568686e/go.mod"
	"github.com/stretchr/testify v1.11.1"
	"github.com/stretchr/testify v1.11.1/go.mod"
	"github.com/tidwall/gjson v1.14.2/go.mod"
	"github.com/tidwall/gjson v1.18.0"
	"github.com/tidwall/gjson v1.18.0/go.mod"
	"github.com/tidwall/match v1.1.1"
	"github.com/tidwall/match v1.1.1/go.mod"
	"github.com/tidwall/pretty v1.2.0/go.mod"
	"github.com/tidwall/pretty v1.2.1"
	"github.com/tidwall/pretty v1.2.1/go.mod"
	"github.com/tidwall/sjson v1.2.5"
	"github.com/tidwall/sjson v1.2.5/go.mod"
	"github.com/yuin/goldmark v1.7.13"
	"github.com/yuin/goldmark v1.7.13/go.mod"
	"go.mau.fi/util v0.9.1"
	"go.mau.fi/util v0.9.1/go.mod"
	"go.mau.fi/zeroconfig v0.2.0"
	"go.mau.fi/zeroconfig v0.2.0/go.mod"
	"golang.org/x/crypto v0.42.0"
	"golang.org/x/crypto v0.42.0/go.mod"
	"golang.org/x/exp v0.0.0-20250911091902-df9299821621"
	"golang.org/x/exp v0.0.0-20250911091902-df9299821621/go.mod"
	"golang.org/x/net v0.44.0"
	"golang.org/x/net v0.44.0/go.mod"
	"golang.org/x/sync v0.17.0"
	"golang.org/x/sync v0.17.0/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.12.0/go.mod"
	"golang.org/x/sys v0.36.0"
	"golang.org/x/sys v0.36.0/go.mod"
	"golang.org/x/text v0.29.0"
	"golang.org/x/text v0.29.0/go.mod"
	"google.golang.org/protobuf v1.36.9"
	"google.golang.org/protobuf v1.36.9/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c/go.mod"
	"gopkg.in/natefinch/lumberjack.v2 v2.2.1"
	"gopkg.in/natefinch/lumberjack.v2 v2.2.1/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	"maunium.net/go/mauflag v1.0.0"
	"maunium.net/go/mauflag v1.0.0/go.mod"
	"maunium.net/go/mautrix v0.25.1"
	"maunium.net/go/mautrix v0.25.1/go.mod"
)

go-module_set_globals

DESCRIPTION="Matrix-Signal puppeting bridge"
HOMEPAGE="https://github.com/mautrix/signal"
SRC_URI="https://github.com/mautrix/signal/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
S="${WORKDIR}/signal-${PV}"

LICENSE="AGPL-3+"
# Go dependency licenses
LICENSE+=" AGPL-3 Apache-2.0 BSD GPL-3+ ISC MIT MPL-2.0 public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/mautrix-signal
	dev-libs/olm
"
DEPEND="${RDEPEND}
	~dev-libs/libsignal-ffi-0.80.3
"

DOCS=( {CHANGELOG,README,ROADMAP}.md )

pkg_setup() {
	[[ ${MERGE_TYPE} == "binary" ]] && return 0

	# https://github.com/mautrix/signal/issues/595
	tc-is-clang && die "Clang compiler is not supported"
}

src_compile() {
	local MAUTRIX_VERSION=$(awk '/maunium\.net\/go\/mautrix / { print $2 }' go.mod)
	local BUILD_TIME=$(date -Iseconds)
	local go_ldflags=(
		-X "main.Tag=v${PV}"
		-X "main.BuildTime=${BUILD_TIME}"
		-X "maunium.net/go/mautrix.GoModVersion=${MAUTRIX_VERSION}"
	)

	ego build -ldflags "${go_ldflags[*]}" ./cmd/mautrix-signal
}

src_install() {
	dobin mautrix-signal
	einstalldocs

	newinitd "${FILESDIR}"/mautrix-signal.initd-r1 mautrix-signal
	newconfd "${FILESDIR}"/mautrix-signal.confd mautrix-signal
	systemd_dounit "${FILESDIR}"/mautrix-signal.service

	local dir
	for dir in /var/log/mautrix /etc/mautrix; do
		keepdir "${dir}"
		fowners -R root:mautrix "${dir}"
		fperms 770 "${dir}"
	done

	keepdir /var/lib/mautrix/signal
	fowners -R mautrix-signal:mautrix /var/lib/mautrix/signal
}

src_test() {
	ego test -vet=off ./...
}

pkg_postinst() {
	einfo
	elog "Before you can use mautrix-signal, you need to configure it correctly."
	elog "To generate the configuration file, use the following command:"
	elog "	# runuser -u mautrix-signal -g mautrix -- mautrix-signal -c /etc/mautrix/mautrix_signal.yaml -e"
	elog
	elog "Configure the /etc/mautrix/mautrix_signal.yaml file according to your"
	elog "homeserver. When done, run the following command:"
	elog "	# emerge --config ${CATEGORY}/${PN}"
	elog
	elog "Then, you need to register the bridge with your homeserver."
	elog "Refer your homeserver's documentation for instructions."
	elog "The registration file is located at /var/lib/mautrix/signal/registration.yaml"
	elog
	elog "Finally, you may start the mautrix-signal daemon."
	einfo
}

pkg_config() {
	runuser -u mautrix-signal -g mautrix -- \
		mautrix-signal -c /etc/mautrix/mautrix_signal.yaml -g -r /var/lib/mautrix/signal/registration.yaml
}
