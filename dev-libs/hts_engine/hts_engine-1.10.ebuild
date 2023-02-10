# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="HMM-based speech synthesis system (HTS) engine and API"
HOMEPAGE="https://hts-engine.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/hts-engine/hts_engine_API-${PV}.tar.gz"
S="${WORKDIR}/hts_engine_API-${PV}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="speech-tools"

DEPENDS="speech-tools? ( app-accessibility/speech-tools )"

src_configure() {
	econf $(use_enable speech-tools festival)
}
