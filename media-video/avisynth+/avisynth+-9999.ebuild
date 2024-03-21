# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [ "${PV#9999}" != "${PV}" ] ; then
	SCM="git-r3"
	EGIT_REPO_URI="https://github.com/AviSynth/AviSynthPlus.git"
fi

inherit cmake-multilib ${SCM}

DESCRIPTION="A powerful nonlinear scripting language for video"
HOMEPAGE="https://github.com/AviSynth/AviSynthPlus"
if [ "${PV#9999}" != "${PV}" ] ; then
	SRC_URI=""
else # TODO release
	SRC_URI=""
fi

LICENSE="GPL-2"
SLOT="0"
if [ "${PV#9999}" = "${PV}" ] ; then
	KEYWORDS="~amd64"
fi

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/avisynth+-9999-return-type-warning.patch"
)

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/avisynth/avs/arch.h
)

pkg_postinst() {
	elog "Integration with some packages can be achieved by setting environment"
	elog "variables and re-emerging the package:"
	elog ""
	elog "media-video/ffmpeg:"
	elog "  - add \"--enable-avisynth\" to EXTRA_FFMPEG_CONF"
	elog ""
	elog "media-libs/ffmpegsource:"
	elog "  - add \"--enable-avisynth\" to EXTRA_ECONF"
	elog "  - add \"-I/usr/include/avisynth\" to CXXFLAGS"
}
