# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="forceoptional"
KFMIN=5.38.0
QTMIN=5.4.0
inherit ecm git-r3

DESCRIPTION="Gemini KIO slave"
HOMEPAGE="https://invent.kde.org/tobias/kio-gemini"
EGIT_REPO_URI="https://invent.kde.org/tobias/kio-gemini.git"
EGIT_COMMIT="d60b94caae7a4c295c0aefc4415555bb5ba62a3f"

LICENSE="LGPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE=""

DEPEND="
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
"
RDEPEND="${DEPEND}"
