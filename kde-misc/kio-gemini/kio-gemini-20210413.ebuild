# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="d60b94caae7a4c295c0aefc4415555bb5ba62a3f"
ECM_HANDBOOK="forceoptional"
KFMIN=5.38.0
QTMIN=5.4.0
inherit ecm

DESCRIPTION="Gemini KIO slave"
HOMEPAGE="https://invent.kde.org/tobias/kio-gemini"
SRC_URI="https://invent.kde.org/tobias/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE=""

DEPEND="
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
"
RDEPEND="${DEPEND}"
