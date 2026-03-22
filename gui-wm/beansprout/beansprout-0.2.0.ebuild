# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_SLOT="0.15"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://codeberg.org/beansprout/beansprout.git"
	inherit git-r3
else
	declare -g -r -A ZBS_DEPENDENCIES=(
		[args-0.0.0-CiLiqojRAACGzDRO7A9dw7kWSchNk29caJZkXuMCb0Cn.tar.gz]='https://github.com/ikskuh/zig-args/archive/8ae26b44a884ff20dca98ee84c098e8f8e94902f.tar.gz'
		[fcft-3.0.0-zcx6CxQfAADhnwm8SjyCkQF-VFHGiVarigc2de3ciInC.tar.gz]='https://git.sr.ht/~novakane/zig-fcft/archive/4bf5be61c869d08d5bcb0306049c63a9cb0795a7.tar.gz'
		[kdl-0.0.0-8rilEKdHAQC_NOLDNu3Ts6kJT8uqqJvrPduFScEjSm_g.tar.gz]='https://codeberg.org/bwbuhse/zig-kdl/archive/13d9d247324f79b854187d6becc47fffdf7fea3b.tar.gz'
		[known_folders-0.0.0-Fy-PJv3LAAABBRVoZWVrKZdyLoUfl5VRY5fqRRRdnF5L.tar.gz]='https://github.com/ziglibs/known-folders/archive/83d39161eac2ed6f37ad3cb4d9dd518696ce90bb.tar.gz'
		[pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX.tar.gz]='https://codeberg.org/ifreund/zig-pixman/archive/v0.3.0.tar.gz'
		[wayland-0.5.0-dev-lQa1kv_ZAQCZfnVZMocokZ78QJbH6NaM5RUC9ODQPhx5.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/e57368ecbda85d564362779b253b744260a4b053.tar.gz'
		[xkbcommon-0.4.0-dev-VDqIe0y2AgCNeWLthDZ3MUcUYzhyKXjK85ISm_zxk9Nk.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/6786ca619bb442c3f523b5bb894e6a1e48d7e897.tar.gz'
		[zeit-0.6.0-5I6bk36tAgATpSl9wjFmRPMqYN2Mn0JQHgIcRNcqDpJA.tar.gz]='https://github.com/rockorager/zeit/archive/7ac64d72dbfb1a4ad549102e7d4e232a687d32d8.tar.gz'
		[zigimg-0.1.0-8_eo2kSGFwADIkeZYTgfnLOV-khh6ZRoGmK6F2-s_QbY.tar.gz]='https://github.com/zigimg/zigimg/archive/fb74dfb7c6d83f2bd01a229826669451525a4ba8.tar.gz'
	)
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

inherit zig

DESCRIPTION="A tiling window manager for the river Wayland compositor"
HOMEPAGE="https://codeberg.org/beansprout/beansprout"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="
		https://codeberg.org/beansprout/beansprout/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${ZBS_DEPENDENCIES_SRC_URI}
	"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="man"

BDEPEND="
	dev-libs/wayland-protocols
	man? ( app-text/scdoc )
"
DEPEND="
	dev-libs/wayland
	media-libs/fcft
	x11-libs/libxkbcommon
	x11-libs/pixman
"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		zig_live_fetch
	else
		zig_src_unpack
	fi
}

src_configure() {
	local my_zbs_args=(
		-Dstrip=false # Let Portage control this
		-Dpie=true
		-Dman-pages=$(usex man true false)
	)

	zig_src_configure
}
