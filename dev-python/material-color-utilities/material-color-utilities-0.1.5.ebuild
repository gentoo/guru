# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Python port of material-color-utilities used for Material You colors"
HOMEPAGE="https://python-telegram-bot.org https://github.com/python-telegram-bot/python-telegram-bot"
SRC_URI="https://files.pythonhosted.org/packages/source/${PN::1}/${PN}-python/${PN}-python-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}/${PN}-python-${PV}
BDEPEND="
	${PYTHON_DEPS}
	dev-python/poetry-core
"
