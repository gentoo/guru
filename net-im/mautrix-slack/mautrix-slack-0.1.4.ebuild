# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="A Matrix-Slack puppeting bridge based on slack-go"
HOMEPAGE="https://github.com/mautrix/slack"
SRC_URI="https://github.com/mautrix/slack/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://jroy.ca/dist/${P}-deps.tar.xz
"
S="${WORKDIR}/slack-${PV}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/${PN}
	dev-libs/olm
"
DEPEND="${RDEPEND}"

src_compile() {
	ego build "${S}"/cmd/"${PN}"
}

src_install() {
	dobin mautrix-slack

	keepdir /var/log/mautrix/slack
	fowners -R root:mautrix /var/log/mautrix
	fperms -R 770 /var/log/mautrix

	insinto "/etc/mautrix"
	newins "${S}/pkg/connector/example-config.yaml" "${PN/-/_}.yaml"

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"

	keepdir /etc/mautrix
	fowners -R root:mautrix /etc/mautrix
	fperms -R 770 /etc/mautrix
}

pkg_postinst() {
	einfo
	elog ""
	elog "Before you can use ${PN}, you must configure it correctly"
	elog "To generate the configuration file, use the following command:"
	elog "mautrix-signal -e"
	elog "Then move the config.yaml file to /etc/mautrix/${PN/-/_}.yaml"
	elog "Configure the file according to your homeserver"
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
