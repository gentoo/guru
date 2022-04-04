# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="false"
KFMIN=5.70.0
QTMIN=5.15.0
inherit git-r3 ecm

DESCRIPTION="Set of chat components for QtQuick chat apps"
HOMEPAGE="https://invent.kde.org/libraries/kquickchatcomponents"
EGIT_REPO_URI="https://invent.kde.org/libraries/kquickchatcomponents.git"

LICENSE="CC0-1.0 LGPL-2+"
SLOT="5"
KEYWORDS=""

DEPEND="
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
"
RDEPEND="${DEPEND}"

DOCS=( README.md examples )
