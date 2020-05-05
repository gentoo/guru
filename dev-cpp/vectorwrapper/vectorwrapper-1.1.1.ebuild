# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A template vector wrapper class for C++"
HOMEPAGE="https://alarmpi.no-ip.org/gitan/King_DuckZ/vectorwrapper"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="http://alarmpi.no-ip.org/gitan/King_DuckZ/vectorwrapper.git"
	inherit git-r3
else
	SRC_URI="https://alarmpi.no-ip.org/gitan/King_DuckZ/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}"/"${PN}"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local emesonargs=(
		$(meson_use test build_testing)
	)
	meson_src_configure
}
