# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 git-r3

DESCRIPTION="Python port of material-color-utilities used for Material You colors"
HOMEPAGE="https://python-telegram-bot.org https://github.com/python-telegram-bot/python-telegram-bot"
EGIT_REPO_URI="https://github.com/avanishsubbiah/material-color-utilities-python"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

BDEPEND="
	${PYTHON_DEPS}
	dev-python/poetry-core
"
