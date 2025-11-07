# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd toolchain-funcs

MY_PV="0.$(ver_rs 1-2 '').0"
DESCRIPTION="Matrix-Signal puppeting bridge"
HOMEPAGE="https://github.com/mautrix/signal"
SRC_URI="https://github.com/mautrix/signal/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-golang-dist/signal/releases/download/v${MY_PV}/signal-${MY_PV}-vendor.tar.xz"
S="${WORKDIR}/signal-${MY_PV}"

LICENSE="AGPL-3+"
# Go dependency licenses
LICENSE+=" AGPL-3 Apache-2.0 BSD GPL-3+ ISC MIT MPL-2.0 public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/mautrix-signal
	dev-libs/olm
	virtual/zlib:=
"
DEPEND="${RDEPEND}
	~dev-libs/libsignal-ffi-0.84.0
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
