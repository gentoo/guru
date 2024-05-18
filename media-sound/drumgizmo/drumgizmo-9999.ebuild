# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Cross-platform drum plugin and stand-alone application"
HOMEPAGE="https://www.drumgizmo.org/wiki"
EGIT_REPO_URI="https://git.drumgizmo.org/${PN}.git"

LICENSE="LGPL-3"
SLOT="0"
IUSE="alsa jack lv2 vst cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3"

DEPEND="
	alsa? ( media-libs/alsa-lib )
	lv2? ( media-libs/lv2 )
	media-libs/libsmf
	media-libs/libsndfile
	media-libs/zita-resampler
	x11-libs/libX11
"
RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( alsa jack )"

src_configure() {
	local sse=0
	use cpu_flags_x86_sse  && sse=1
	use cpu_flags_x86_sse2 && sse=2
	use cpu_flags_x86_sse3 && sse=3

	econf --enable-cli=yes \
		--enable-static=no \
		$(usex alsa '' '--disable-output-alsa') \
		$(usex jack '' '--disable-input-jackmidi') \
		$(usex jack '' '--disable-output-jackaudio') \
		--enable-gui=x11 \
		--enable-lv2=$(usex lv2) \
		--enable-sse=${sse} \
		--enable-vst=$(usex vst) \
		--with-debug=no \
		--with-test=no
}
