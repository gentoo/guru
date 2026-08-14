# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Red Hat's Open Source Fonts - Red Hat Display and Red Hat Text"
HOMEPAGE="https://redhatofficial.github.io/RedHatFont/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/RedHatOfficial/RedHatFont.git"
else
	SRC_URI="https://github.com/RedHatOfficial/RedHatFont/archive/refs/tags/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/RedHatFont-${PV}"
fi

LICENSE="OFL-1.1"
SLOT="0"

IUSE="+ttf otf variable webfonts +redhatmono +redhatdisplay +redhattext"
IUSE_FONTS="redhatmono redhatdisplay redhattext"
IUSE_TYPE="ttf otf variable webfonts"
REQUIRED_USE="|| ( ${IUSE_TYPE} ) || ( ${IUSE_FONTS} )"
src_install() {
	local font suffix
	for font in RedHatMono RedHatDisplay RedHatText; do
		use "${font,,}" || continue
		for suffix in ${IUSE_TYPE}; do
			use "${suffix}" || continue
			if [[ ${suffix} == variable ]]; then
				FONT_SUFFIX="ttf"
			elif [[ ${suffix} == webfonts ]]; then
				FONT_SUFFIX="woff2"
			else
				FONT_SUFFIX="${suffix}"
			fi
			if [[ ${font} == RedHatMono ]]; then
				FONT_S="${S}/fonts/Mono/${font}/${suffix}"
			else
				FONT_S="${S}/fonts/Proportional/${font}/${suffix}"
			fi
			font_src_install
		done
	done

}
