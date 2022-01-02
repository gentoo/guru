# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="ff6beb59a927c3f3744261b35a5fb65682073e80"

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
