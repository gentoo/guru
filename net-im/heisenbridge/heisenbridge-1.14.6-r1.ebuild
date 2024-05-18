# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 systemd

DESCRIPTION="A bouncer-style Matrix IRC bridge"
HOMEPAGE="https://github.com/hifi/heisenbridge/"
SRC_URI="https://github.com/hifi/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/heisenbridge
	<dev-python/aiohttp-4[${PYTHON_USEDEP}]
	dev-python/async-timeout[${PYTHON_USEDEP}]
	dev-python/irc[${PYTHON_USEDEP}]
	dev-python/mautrix[${PYTHON_USEDEP}]
	dev-python/python-socks[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/heisenbridge-1.14.1-qanotice.patch"
)

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	echo ${PV} > ${PN}/version.txt || die
}

src_install() {
	distutils-r1_src_install

	newinitd "${FILESDIR}"/heisenbridge.initd ${PN}
	newconfd "${FILESDIR}"/heisenbridge.confd ${PN}
	systemd_dounit "${FILESDIR}"/${PN}.service
}

pkg_postinst() {
	[[ -f "${EPREFIX}"/var/lib/${PN}/registration.yaml ]] && return 0

	einfo
	elog "Before you can use ${PN}, you have to configure it correctly."
	elog "The configuration file is located at /etc/conf.d/${PN}"
	elog
	elog "Then, you must generate the registration file using the following command:"
	elog "* If you are using Synapse:"
	elog "\t${PN} -c /var/lib/${PN}/registration.yaml --generate https://example.com"
	elog "* If you are using Dendrite, Conduit or others:"
	elog "\t${PN} -c /var/lib/${PN}/registration.yaml --generate-compat https://example.com"
	elog
	elog "Notice the URL at the end, replace it with your homeserver's URL."
	elog "Then, you must register the bridge with your homeserver."
	elog "Refer to your homeserver's documentation for instructions."
	elog "The registration file is located at /var/lib/${PN}/registration.yaml"
	elog "Finally, you may start the ${PN} daemon."
	einfo

}
