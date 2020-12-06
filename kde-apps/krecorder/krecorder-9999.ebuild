# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="false"
QTMIN=5.15.1

inherit ecm

DESCRIPTION="A convergent audio recording application for Plasma"
HOMEPAGE="https://invent.kde.org/plasma-mobile/krecorder"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://invent.kde.org/plasma-mobile/${PN}.git"
else
	SRC_URI=""
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	>=dev-qt/qtcore-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtmultimedia-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	sys-devel/gettext
"
RDEPEND="
	${DEPEND}
	kde-frameworks/kconfig:5
	kde-frameworks/ki18n:5
	kde-frameworks/kirigami:5
"
