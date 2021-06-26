# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="36930ed14d2b8f1f45bb72aa10e5a6ed9a7fc240"

DESCRIPTION="ALSA ucm configuration files for PinePhone"
HOMEPAGE="https://gitlab.com/pine64-org/pine64-alsa-ucm"
SRC_URI="https://gitlab.com/pine64-org/pine64-alsa-ucm/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="media-libs/alsa-ucm-conf"

S="${WORKDIR}/pine64-alsa-ucm-${COMMIT}/ucm2/PinePhone"

src_install() {
	insinto /usr/share/alsa/ucm2/PinePhone
	doins -r "${FILESDIR}"/*.conf
}
