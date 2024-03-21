# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A privacy tool that makes keystroke biometrics less effective"
HOMEPAGE="https://github.com/Whonix/kloak"
SRC_URI="https://gitlab.com/whonix/kloak/-/archive/0.2.30-2/${P}-2.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${P}-2"
RDEPEND="${DEPEND}"
CONFIG_CHECK="~UINPUT"
PATCHES=(
	"${FILESDIR}"/toolchain-call.patch
)
src_install() {
	dobin eventcap
	dobin kloak
	doman auto-generated-man-pages/eventcap.8
	doman auto-generated-man-pages/kloak.8
}
