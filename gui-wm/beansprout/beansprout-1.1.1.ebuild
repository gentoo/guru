# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_SLOT="0.16"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://codeberg.org/beansprout/beansprout.git"
	inherit git-r3
else
	declare -g -r -A ZBS_DEPENDENCIES=(
		[fcft-3.0.0-zcx6CxQfAADhnwm8SjyCkQF-VFHGiVarigc2de3ciInC.tar.gz]='https://git.sr.ht/~novakane/zig-fcft/archive/4bf5be61c869d08d5bcb0306049c63a9cb0795a7.tar.gz'
		[kdl-0.0.0-8rilELAEAgCwhdgb36ZsWmGgtvrKaLmLI7eMlwBz8UDt.tar.gz]='https://codeberg.org/desttinghim/zig-kdl/archive/22fa7655d70de1f447c864921ab847effec355f3.tar.gz'
		[known_folders-0.0.0-Fy-PJk3KAACzUg2us_0JvQQmod1ZA8jBt7MuoKCihq88.tar.gz]='https://github.com/ziglibs/known-folders/archive/d6d03830968cca6b7b9f24fd97ee348346a6905d.tar.gz'
		[pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX.tar.gz]='https://codeberg.org/ifreund/zig-pixman/archive/v0.3.0.tar.gz'
		[wayland-0.6.0-lQa1kqz8AQADQmdNJsNhLoNHcnEGEUjrOaPV-dtEnEmX.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.6.0.tar.gz'
		[xkbcommon-0.4.0-VDqIe0i2AgDRsok2GpMFYJ8SVhQS10_PI2M_CnHXsJJZ.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.4.0.tar.gz'
		[zeit-0.6.0-5I6bk7q6AgBdMJxze3D4l9ylQhkviQ_BX9FigDt13MFn.tar.gz]='https://github.com/rockorager/zeit/archive/refs/tags/v0.8.0.tar.gz'
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

BDEPEND="
	dev-libs/wayland-protocols
	app-text/scdoc
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
		zig_live_src_unpack
		# Workaround from vimproved until the eclass is updated
		ln -s "${WORKDIR}/zig-pkg" "${S}/zig-pkg" || die
	else
		zig_src_unpack
	fi
}

src_configure() {
	local my_zbs_args=(
		-Dstrip=false # Let Portage control this
		-Dpie=true
		-Dman-pages=true
	)

	zig_src_configure
}
