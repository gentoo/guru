# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature pypi systemd

DESCRIPTION="A Matrix-Telegram Messenger puppeting bridge "
HOMEPAGE="https://github.com/mautrix/telegram/"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="crypt minimal +qrcode socks5 sqlite"

RDEPEND="
	acct-user/mautrix-telegram
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/asyncpg[${PYTHON_USEDEP}]
	dev-python/commonmark[${PYTHON_USEDEP}]
	dev-python/mako[${PYTHON_USEDEP}]
	dev-python/mautrix[crypt?,${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/tulir-telethon-1.37.0_alpha1[${PYTHON_USEDEP}]
	dev-python/yarl[${PYTHON_USEDEP}]
	|| (
		dev-python/python-magic[${PYTHON_USEDEP}]
		sys-apps/file[python,${PYTHON_USEDEP}]
	)
	!minimal? (
		app-arch/brotli[python,${PYTHON_USEDEP}]
		dev-python/aiodns[${PYTHON_USEDEP}]
		dev-python/cryptg[${PYTHON_USEDEP}]
		dev-python/phonenumbers[${PYTHON_USEDEP}]
	)
	qrcode? (
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/qrcode[${PYTHON_USEDEP}]
	)
	socks5? ( dev-python/python-socks[${PYTHON_USEDEP}] )
	sqlite? ( dev-python/aiosqlite[${PYTHON_USEDEP}] )
"

src_install() {
	distutils-r1_src_install

	keepdir /var/log/mautrix
	fowners root:mautrix /var/log/mautrix
	fperms 770 /var/log/mautrix

	mkdir -p "${ED}"/etc/mautrix || die
	sed -i "${ED}/usr/example-config.yaml" \
		-e "s:\./mautrix-telegram.log:/var/log/mautrix/${PN}.log:" || die
	mv "${ED}"/usr/example-config.yaml "${ED}"/etc/mautrix/mautrix_telegram.yaml || die

	newinitd "${FILESDIR}"/mautrix-telegram.initd-r1 mautrix-telegram
	newconfd "${FILESDIR}"/mautrix-telegram.confd mautrix-telegram
	systemd_dounit "${FILESDIR}"/mautrix-telegram.service

	fowners -R root:mautrix /etc/mautrix
	fperms -R 770 /etc/mautrix
}

pkg_postinst() {
	optfeature "Prometheus statistics support" dev-python/prometheus_client

	einfo
	elog "Before you can use mautrix-telegram, you need to configure it correctly."
	elog "The configuration file is located at \"/etc/mautrix/mautrix_telegram.yaml\""
	elog
	elog "When done, run the following command:"
	elog "	# emerge --config ${CATEGORY}/${PN}"
	elog
	elog "Then, you need to register the bridge with your homeserver."
	elog "Refer your homeserver's documentation for instructions."
	elog "The registration file is located at /var/lib/mautrix_telegram/registration.yaml"
	elog
	elog "Finally, you may start the mautrix-telegram daemon."
	einfo
}

pkg_config() {
	su - mautrix-telegram -s /bin/sh -c \
		"/usr/bin/python -m mautrix_telegram -c /etc/mautrix/mautrix_telegram.yaml -g -r /var/lib/mautrix_telegram/registration.yaml"
}
