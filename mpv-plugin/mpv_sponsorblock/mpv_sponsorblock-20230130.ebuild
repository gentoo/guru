# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
PYTHON_COMPAT=( python3_{10..12} pypy3 )
inherit mpv-plugin python-single-r1

COMMIT="7785c1477103f2fafabfd65fdcf28ef26e6d7f0d"
DESCRIPTION="mpv script to skip sponsored segments of YouTube videos"
HOMEPAGE="https://github.com/po5/mpv_sponsorblock"
SRC_URI="https://github.com/po5/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
"

MPV_PLUGIN_FILES=(
	sponsorblock_shared
	sponsorblock.lua
)

src_prepare() {
	default

	# we 1) install in the system folder 2) use EPYTHON
	sed -i sponsorblock.lua \
		-e 's|scripts_dir =.*|scripts_dir = "/etc/mpv/scripts"|' \
		-e "s|python3|${EPYTHON}|" || die
}
