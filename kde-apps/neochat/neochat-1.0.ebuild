# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

DESCRIPTION="A client for matrix, the decentralized communication protocol"
HOMEPAGE="https://invent.kde.org/network/neochat"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://invent.kde.org/network/neochat.git"
else
	SRC_URI="https://invent.kde.org/network/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	app-text/cmark
	dev-libs/libQuotient
	dev-qt/qtgui
	dev-libs/qtkeychain
	dev-qt/qtnetwork
	dev-qt/qtsvg
	kde-frameworks/kconfig
	kde-frameworks/kcoreaddons
	kde-frameworks/kdbusaddons
	kde-frameworks/ki18n
	kde-frameworks/kirigami
	kde-frameworks/knotifications
	kde-frameworks/kquickimageeditor

"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-v${PV}"
