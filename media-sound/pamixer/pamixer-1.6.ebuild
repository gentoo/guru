# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pulseaudio command line mixer."
HOMEPAGE="https://github.com/cdemoulins/pamixer"

inherit meson

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cdemoulins/pamixer"
else
	SRC_URI="https://github.com/cdemoulins/pamixer/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	dev-libs/cxxopts
	media-libs/libpulse
"

DEPEND="${RDEPEND}"

src_prepare() {
	eapply_user
	sed -i 's/1.6/1.17/;s/c++11/c++17/' meson.build || die "Sed failed!"
}
