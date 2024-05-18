# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

MY_PN="${PN}.vim"
DESCRIPTION="vim plugin: Qt, qmake, QML, Qbs, QRC, UI and TS support"
HOMEPAGE="https://github.com/fedorenchik/qt-support.vim"
SRC_URI="https://github.com/fedorenchik/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
KEYWORDS="~amd64"
