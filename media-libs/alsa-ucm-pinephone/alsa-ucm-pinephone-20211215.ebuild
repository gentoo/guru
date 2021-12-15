# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="0156de7f6cded94d8dc0c7ac76cfa8fbc4b38151"

DESCRIPTION="ALSA ucm configuration files for PinePhone bases on the Manjaro ARM repo"
HOMEPAGE="https://gitlab.manjaro.org/manjaro-arm/packages/community/pinephone/alsa-ucm-pinephone"
SRC_URI="https://gitlab.manjaro.org/manjaro-arm/packages/community/pinephone/alsa-ucm-pinephone/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="
	>=media-libs/alsa-ucm-conf-1.2.6
	"

DEPEND="${RDEPEND}"

BDEPEND="${RDEPEND}"

S="${WORKDIR}/alsa-ucm-pinephone-${COMMIT}"

src_install() {
	insinto /usr/share/alsa/ucm2/PinePhone
	doins -r "${S}"/*.conf
}
