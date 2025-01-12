# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for managing settings of CoreApps"
HOMEPAGE="https://gitlab.com/cubocore/libcprime"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/libcprime.git"
else
	COMMIT="eff16e1d89bd98d8a4fd22c6decbdc1c573ecca1"
	SRC_URI="https://gitlab.com/cubocore/libcprime/-/archive/${COMMIT}.tar.bz2 -> ${P}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="GPL-3+"
SLOT="0"

DEPEND="dev-qt/qtbase:6[dbus,gui,network,widgets]"
RDEPEND="${DEPEND}"
