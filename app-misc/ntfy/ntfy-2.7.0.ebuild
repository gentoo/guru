# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit distutils-r1

DESCRIPTION="A utility for sending notifications, on demand and when commands finish."
HOMEPAGE="https://github.com/dschep/ntfy"
SRC_URI="https://github.com/dschep/ntfy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

IUSE="telegram dbus"

RDEPEND="
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]

	dbus? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		virtual/notification-daemon
	)

	telegram? (
		app-misc/telegram-send[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}
	test? (
		dev-python/emoji[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/sleekxmpp[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs
