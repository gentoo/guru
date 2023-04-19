# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd udev

EGO_SUM=(
	"github.com/BurntSushi/toml v0.3.1"
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/felixge/httpsnoop v1.0.1"
	"github.com/felixge/httpsnoop v1.0.1/go.mod"
	"github.com/gorilla/csrf v1.7.0"
	"github.com/gorilla/csrf v1.7.0/go.mod"
	"github.com/gorilla/handlers v1.5.1"
	"github.com/gorilla/handlers v1.5.1/go.mod"
	"github.com/gorilla/mux v1.8.0"
	"github.com/gorilla/mux v1.8.0/go.mod"
	"github.com/gorilla/securecookie v1.1.1"
	"github.com/gorilla/securecookie v1.1.1/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/natefinch/lumberjack.v2 v2.0.0"
	"gopkg.in/natefinch/lumberjack.v2 v2.0.0/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
)

go-module_set_globals

DESCRIPTION="TREZOR Communication Daemon"
HOMEPAGE="https://github.com/trezor/trezord-go"
SRC_URI="
	https://github.com/trezor/trezord-go/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd +udev"
RESTRICT="mirror test"

DEPEND="
	acct-user/trezord
	acct-group/plugdev
"

src_compile() {
	default
	go build -v -work -x -o ${PN} || die
}

src_install() {
	newbin trezord-go trezord
	newinitd "${FILESDIR}/trezord-openrc.sh" trezord
	keepdir /var/log/trezord
	fowners trezord:root /var/log/trezord
	einstalldocs

	use systemd && systemd_dounit release/linux/trezord.service
	use udev && udev_dorules release/linux/trezor.rules
}

pkg_postinst() {
	use udev && udev_reload
}

pkg_postrm() {
	use udev && udev_reload
}
