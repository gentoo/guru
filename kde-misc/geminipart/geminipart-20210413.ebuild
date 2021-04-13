# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="11e93034deaacee8237ac79f46854b15368f1e9c"
KFMIN=5.16.0
QTMIN=5.4.0
inherit ecm

DESCRIPTION="KPart for viewing text/gemini files"
HOMEPAGE="https://invent.kde.org/tobias/geminipart"
SRC_URI="https://invent.kde.org/tobias/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE=""

DEPEND="
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kparts-${KFMIN}:5
"
RDEPEND="${DEPEND}"
