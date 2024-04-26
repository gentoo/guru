# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A daemon to provide haptic feedback on events (themes package)"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd-device-themes"
SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/${MY_PV}/${MY_P}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
