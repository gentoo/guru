# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN="6.0.0"
inherit ecm

DESCRIPTION="KDE helper to boost foreground apps using dmem cgroup limits"
HOMEPAGE="https://github.com/pixelcluster/kcgroups"
MY_TAG="dmemcg-experimental"
SRC_URI="https://github.com/pixelcluster/kcgroups/archive/refs/tags/booster-${MY_TAG}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/kcgroups-booster-${MY_TAG}"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6
	kde-frameworks/kconfig:6
	kde-frameworks/kdbusaddons:6
	kde-frameworks/kwindowsystem:6
	kde-misc/kcgroups-dmemcg
	kde-plasma/plasma-workspace:6
"
RDEPEND="${DEPEND}"
