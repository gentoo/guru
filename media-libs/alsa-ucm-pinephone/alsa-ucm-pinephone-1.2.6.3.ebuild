# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="ec0ef36b8b897ed1ae6bb0d0de13d5776f5d3659"

MY_PN="pine64-alsa-ucm"
DESCRIPTION="ALSA ucm configuration files for the PinePhone (Pro)"
HOMEPAGE="https://gitlab.com/pine64-org/pine64-alsa-ucm"
SRC_URI="https://gitlab.com/pine64-org/${MY_PN}/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-alsa-ucm-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="
	>=media-libs/alsa-topology-conf-1.2.5
	>=media-libs/alsa-lib-1.2.6
	>=media-plugins/alsa-plugins-1.2.6
	>=media-libs/alsa-ucm-conf-1.2.6
	>=media-video/pipewire-0.3.42
"
DEPEND="${RDEPEND}"

src_install() {
	# PinePhone Configs
	insinto /usr/share/alsa/ucm2/PinePhone/
	insopts -m644
	doins "${S}"/ucm2/PinePhone/HiFi.conf
	doins "${S}"/ucm2/PinePhone/VoiceCall.conf
	doins "${FILESDIR}"/PinePhone.conf

	# PinePhone Pro Configs
	insinto /usr/share/alsa/ucm2/PinePhonePro/
	insopts -m644
	doins "${S}"/ucm2/PinePhonePro/HiFi.conf
	doins "${S}"/ucm2/PinePhonePro/VoiceCall.conf
	doins "${FILESDIR}"/PinePhonePro.conf

	# Create Symlinks
	dosym ../../../PinePhone/PinePhone.conf /usr/share/alsa/ucm2/conf.d/simple-card/PinePhone.conf
	dosym ../../../PinePhonePro/PinePhonePro.conf /usr/share/alsa/ucm2/conf.d/simple-card/PinePhonePro.conf
}
