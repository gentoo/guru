# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module optfeature systemd

MY_PV=0.${PV/./}.0

DESCRIPTION="A Matrix-WhatsApp puppeting bridge "
HOMEPAGE="https://github.com/mautrix/whatsapp/"
SRC_URI="https://github.com/mautrix/whatsapp/archive/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz
	https://distfiles.chuso.net/distfiles/${P}-deps.tar.xz"
S="${WORKDIR}/whatsapp-${MY_PV}"

LICENSE="AGPL-3 GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="crypt"

DEPEND="crypt? ( dev-libs/olm )"

RDEPEND="
	${DEPEND}
	acct-user/${PN}
"

BDEPEND=">=dev-lang/go-1.25"

src_compile() {
	ego build ./cmd/mautrix-whatsapp $(use crypt || echo '-tags nocrypto')
}

src_install() {
	dobin "${PN}"

	keepdir /var/log/mautrix/${PN/mautrix-/}
	fowners -R root:mautrix /var/log/mautrix
	fperms -R 770 /var/log/mautrix

	(
		echo -e '# Network-specific config options\nnetwork:'
		sed 's/^/    /' pkg/connector/example-config.yaml || die
		cat ../go-mod/maunium.net/go/mautrix@v0.26.3/bridgev2/matrix/mxmain/example-config.yaml || die
	) |
	sed "s_\./logs/bridge\.log_/var/log/mautrix/whatsapp/mautrix-whatsapp.log_" > "${PN/-/_}.yaml" || die

	insinto "/etc/mautrix"
	doins "${PN/-/_}.yaml"

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"

	fowners -R root:mautrix /etc/mautrix
	fperms -R 770 /etc/mautrix
}

pkg_postinst() {
	optfeature "sending GIFs" media-video/ffmpeg

	elog "Before you can use ${PN}, you must configure it correctly"
	elog "The configuration file is located at \"/etc/mautrix/${PN/-/_}.yaml\""
	elog "When done, run the following command: emerge --config ${CATEGORY}/${PN}"
	elog "Then, you must register the bridge with your homeserver"
	elog "Refer your homeserver's documentation for instructions"
	elog "The registration file is located at /var/lib/${PN/-/\/}/registration.yaml"
	elog "Finally, you may start the ${PN} daemon"
}

pkg_config() {
	su - "${PN}" -s /bin/sh -c \
		"/usr/bin/${PN} -c /etc/mautrix/${PN/-/_}.yaml -g -r /var/lib/${PN/-/\/}/registration.yaml"
}
