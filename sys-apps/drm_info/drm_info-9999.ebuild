# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

if [[ "${PV}" == "9999" ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ascent12/drm_info"
else
	SRC_URI="https://github.com/ascent12/drm_info/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Small utility to dump info about DRM devices"
HOMEPAGE="https://github.com/ascent12/drm_info"
LICENSE="MIT"
SLOT="0"

DEPEND="
	x11-libs/libdrm
	dev-libs/json-c:=
"
RDEPEND="${DEPEND}"
