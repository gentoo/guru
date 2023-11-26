# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm kde.org optfeature

DESCRIPTION="Plasma 5 applet for monitoring CPU, GPU and other available temperature sensors"
HOMEPAGE="https://store.kde.org/p/998915/
	https://gitlab.com/agurenko/plasma-applet-thermal-monitor"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	EGIT_REPO_URI="https://gitlab.com/agurenko/${PN}.git"
else
	SRC_URI="https://gitlab.com/agurenko/${PN}/-/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2+"
SLOT="5"

DEPEND="kde-plasma/libplasma:5"
RDEPEND="${DEPEND}
	kde-plasma/ksysguard:5[lm-sensors]
"

pkg_postinst() {
	ecm_pkg_postinst
	optfeature "monitor temperature of NVMe drives" sys-apps/nvme-cli
}
