# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="A Matrix-Discord puppeting bridge"
HOMEPAGE="https://github.com/mautrix/discord"
SRC_URI="
	https://github.com/mautrix/discord/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://vimja.cloud/public.php/dav/files/z59eKDyLFokW2KK/${CATEGORY}/${PN}/${P}-vendor.tar.xz
"
S="${WORKDIR}/discord-${PV}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	acct-user/${PN}
	dev-libs/olm
	dev-util/lottieconverter
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-lang/go-1.25.0"

src_compile() {
	ego build
}

src_install() {
	dobin mautrix-discord

	keepdir /var/log/mautrix/discord
	fowners -R root:mautrix /var/log/mautrix
	fperms -R 770 /var/log/mautrix

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"

	# Unlike other Mautrix bridges, mautrix-discord does not support the -e
	# flag for generating a configuration file. The documentation advises to
	# instead use the sample config from the project repository.
	# https://docs.mau.fi/bridges/go/setup.html#step-2-configuring-and-running
	sed -i -e "s/\.\/logs/\/var\/log\/${PN/-/\\\/}/" "example-config.yaml" || die
	insinto /etc/mautrix
	newins "${S}"/example-config.yaml "${PN/-/_}.yaml"

	fowners -R root:mautrix /etc/mautrix
	fperms -R 770 /etc/mautrix
}

src_test() {
	ego test ./...
}

pkg_postinst() {
	einfo
	elog ""
	elog "Before you can use ${PN}, you must configure it correctly"
	elog "The configuration file is located at \"/etc/mautrix/${PN/-/_}.yaml\""
	elog "When done, run the following command: emerge --config ${CATEGORY}/${PN}"
	elog "Then, you must register the bridge with your homeserver"
	elog "Refer your homeserver's documentation for instructions"
	elog "The registration file is located at /var/lib/${PN/-/\/}/registration.yaml"
	elog "Finally, you may start the ${PN} daemon"
	einfo
}

pkg_config() {
	su - "${PN}" -s /bin/sh -c \
		"/usr/bin/${PN} -c /etc/mautrix/${PN/-/_}.yaml -g -r /var/lib/${PN/-/\/}/registration.yaml"
}
