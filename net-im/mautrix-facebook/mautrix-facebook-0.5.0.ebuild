# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 optfeature systemd

DESCRIPTION="A Matrix-Facebook Messenger puppeting bridge "
HOMEPAGE="https://github.com/mautrix/facebook/"
SRC_URI="https://github.com/mautrix/facebook/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/facebook-${PV}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/${PN}
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/asyncpg[${PYTHON_USEDEP}]
	dev-python/commonmark[${PYTHON_USEDEP}]
	dev-python/mautrix[${PYTHON_USEDEP}]
	dev-python/python-olm[${PYTHON_USEDEP}]
	dev-python/paho-mqtt[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/unpaddedbase64[${PYTHON_USEDEP}]
	dev-python/yarl[${PYTHON_USEDEP}]
	dev-python/zstandard[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

src_install() {
	distutils-r1_src_install

	keepdir /var/log/mautrix
	fowners root:mautrix /var/log/mautrix
	fperms 770 /var/log/mautrix
	sed -i -e "s/\.\/${PN}.log/\/var\/log\/mautrix\/${PN}.log/" "${ED}/usr/example-config.yaml" || die

	insinto "/etc/mautrix"
	newins "${ED}/usr/example-config.yaml" "${PN/-/_}.yaml"
	rm "${ED}/usr/example-config.yaml" || die

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"

	fowners -R root:mautrix /etc/mautrix
	fperms -R 770 /etc/mautrix
}

pkg_postinst() {
	optfeature "Prometheus statistics" dev-python/prometheus_client
	optfeature "Sqlite backend" dev-python/aiosqlite

	einfo
	elog ""
	elog "Before you can use ${PN}, you must configure it correctly"
	elog "The configuration file is located at \"/etc/mautrix/${PN/-/_}.yaml\""
	elog "When done, run the following command: emerge --config ${CATEGORY}/${PN}"
	elog "Then, you must register the bridge with your homeserver"
	elog "Refer to your homeserver's documentation for instructions"
	elog "The registration file is located at /var/lib/${PN/-/\/}/registration.yaml"
	elog "Finally, you may start the ${PN} daemon"
	einfo
}

pkg_config() {
	su - "${PN}" -s /bin/sh -c \
	   "/usr/bin/python -m ${PN/-/_} -c /etc/mautrix/${PN/-/_}.yaml -g -r /var/lib/${PN/-/\/}/registration.yaml"
}
