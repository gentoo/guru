# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 systemd

DESCRIPTION="A bouncer-style Matrix IRC bridge"
HOMEPAGE="https://github.com/hifi/heisenbridge/"
SRC_URI="https://github.com/hifi/heisenbridge/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	acct-user/${PN}
	dev-python/irc[${PYTHON_USEDEP}]
	dev-python/mautrix[${PYTHON_USEDEP}]
	dev-python/python-socks[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/heisenbridge-1.14.1-qanotice.patch"
)

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install

	newinitd "${FILESDIR}/heisenbridge.initd" "${PN}"
	newconfd "${FILESDIR}/heisenbridge.confd" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"
}

pkg_postinst() {
	einfo
	elog "Before you can use ${PN}, you must configure it correctly"
	elog "The configuration file is located at /etc/conf.d/${PN}"
	elog "Then, you must generate the registration file using the following command"
	elog "If you are using synapse:"
	elog "/usr/bin/python -m ${PN} -c /var/lib/${PN}/registration.yaml --generate https://example.com"
	elog "If you are using Dendrite, Conduit or others:"
	elog "/usr/bin/python -m ${PN} -c /var/lib/${PN}/registration.yaml --generate-compat https://example.com"
	elog "Notice the URL at the end, replace it with your homeserver's URL"
	elog "Then, you must register the bridge with your homeserver"
	elog "Refer to your homeserver's documentation for instructions"
	elog "The registration file is located at /var/lib/${PN}/registration.yaml"
	elog "Finally, you may start the ${PN} daemon"
	einfo

}
