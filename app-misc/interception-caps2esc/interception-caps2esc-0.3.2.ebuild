# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Interception tools plugin switching CAPS and ESC"

MY_PN="${PN##interception-}"
MY_P="${MY_PN}-v${PV}"

HOMEPAGE="https://gitlab.com/interception/linux/plugins/caps2esc"
SRC_URI="https://gitlab.com/interception/linux/plugins/${MY_PN}/-/archive/v${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
