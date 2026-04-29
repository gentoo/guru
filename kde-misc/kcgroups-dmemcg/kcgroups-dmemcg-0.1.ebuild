# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN="6.0.0"
inherit ecm

DESCRIPTION="KDE library to manipulate cgroups and boost foreground apps, with dmem cgroup support"
HOMEPAGE="https://github.com/pixelcluster/kcgroups"
MY_TAG="dmemcg-experimental"
SRC_URI="https://github.com/pixelcluster/kcgroups/archive/refs/tags/kcgroups-${MY_TAG}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/kcgroups-kcgroups-${MY_TAG}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6
	kde-frameworks/kconfig:6
	kde-frameworks/kdbusaddons:6
	kde-frameworks/kwindowsystem:6
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	dev-build/ninja
	kde-frameworks/extra-cmake-modules
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_WITH_QT6=ON
	)
	ecm_src_configure
}
