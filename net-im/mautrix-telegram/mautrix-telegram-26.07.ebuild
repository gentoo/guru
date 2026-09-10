# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module optfeature systemd

MY_PV="0.$(ver_rs 1-2 '').0"
DESCRIPTION="Matrix-Telegram puppeting bridge"
HOMEPAGE="https://github.com/mautrix/telegram"
SRC_URI="https://github.com/mautrix/telegram/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sysrq-golang-dist/${PN}/releases/download/v${MY_PV}/${PN}-${MY_PV}-deps.tar.xz"
S="${WORKDIR}/telegram-${MY_PV}"

LICENSE="AGPL-3+"
# Go dependency licenses
LICENSE+=" Apache-2.0 BSD GPL-3+ ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+crypt"

RDEPEND="
	acct-user/mautrix-telegram
	dev-db/sqlite:3
	media-libs/libwebp:=
	crypt? ( dev-libs/olm )
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lang/go-1.25.0
	virtual/pkgconfig
"

DOCS=( {CHANGELOG,README,ROADMAP}.md )

src_configure() {
	default

	# https://github.com/mattn/go-sqlite3#linux
	# -tags libsqlite3: use system sqlite3 instead of bundled
	GO_BUILD_TAGS="libsqlite3"
	use crypt || GO_BUILD_TAGS+=",nocrypto"
}

src_prepare() {
	default

	# unbundle libwebp
	cd "${GOMODCACHE}" || die
	rm go.mau.fi/webp@v0.3.0/z_*.c || die
	eapply "${FILESDIR}"/${PN}-26.07-unbundle-libwebp.patch
}

src_compile() {
	local MAUTRIX_VERSION=$(awk '/maunium\.net\/go\/mautrix / { print $2 }' go.mod)
	local BUILD_TIME=$(date -Iseconds)
	local go_ldflags=(
		-X "main.Tag=v${MY_PV}"
		-X "main.Commit=unknown"
		-X "main.BuildTime=${BUILD_TIME}"
		-X "maunium.net/go/mautrix.GoModVersion=${MAUTRIX_VERSION}"
	)

	ego build -tags "${GO_BUILD_TAGS}" -ldflags "${go_ldflags[*]}" ./cmd/mautrix-telegram
}

src_test() {
	ego test -tags "${GO_BUILD_TAGS}" -vet=off \
		$(ego list ./... | grep -Fvx go.mau.fi/mautrix-telegram/pkg/gotd/tgerr)
}

src_install() {
	dobin mautrix-telegram
	einstalldocs

	newinitd "${FILESDIR}"/mautrix-telegram.initd-r2 mautrix-telegram
	newconfd "${FILESDIR}"/mautrix-telegram.confd mautrix-telegram
	systemd_newunit "${FILESDIR}"/mautrix-telegram.service-r1 mautrix-telegram.service

	local dir
	for dir in /var/log/mautrix /etc/mautrix; do
		keepdir "${dir}"
		fowners -R root:mautrix "${dir}"
		fperms 770 "${dir}"
	done

	keepdir /var/lib/mautrix/telegram
	fowners -R mautrix-telegram:mautrix /var/lib/mautrix/telegram
}

pkg_postinst() {
	einfo
	elog "Before you can use mautrix-telegram, you need to configure it correctly."
	elog "To generate the configuration file, use the following command:"
	elog "	# runuser -u mautrix-telegram -g mautrix -- mautrix-telegram -c /etc/mautrix/mautrix_telegram.yaml -e"
	elog
	elog "Configure the /etc/mautrix/mautrix_telegram.yaml file according to your"
	elog "homeserver. When done, run the following command:"
	elog "	# emerge --config ${CATEGORY}/${PN}"
	elog
	elog "Then, you need to register the bridge with your homeserver."
	elog "Refer your homeserver's documentation for instructions."
	elog "The registration file is located at /var/lib/mautrix/telegram/registration.yaml"
	elog
	elog "Finally, you may start the mautrix-telegram daemon."
	einfo

	optfeature "animated sticker support" "dev-util/lottieconverter media-video/ffmpeg[vpx,webp]"
}

pkg_config() {
	runuser -u mautrix-telegram -g mautrix -- \
		mautrix-telegram -c /etc/mautrix/mautrix_telegram.yaml -g -r /var/lib/mautrix/telegram/registration.yaml
}
