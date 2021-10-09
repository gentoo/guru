# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )
inherit distutils-r1

DESCRIPTION="Send messages and files over Telegram from the command-line"
HOMEPAGE="https://www.rahielkasim.com/telegram-send https://github.com/rahiel/telegram-send"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/python-telegram-bot[${PYTHON_USEDEP}]
"
