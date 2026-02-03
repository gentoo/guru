# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

DESCRIPTION="A key remapping daemon for linux"
HOMEPAGE="https://github.com/rvaiya/keyd"
SRC_URI="https://github.com/rvaiya/keyd/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="acct-group/keyd"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-makefile.patch
)

pkg_pretend() {
	if ! linux_config_exists; then
		eerror "Unable to check your kernel for user level driver support."
	else
		CONFIG_CHECK="~INPUT_UINPUT"
		ERROR_INPUT_UINPUT="You will need user level driver support"
		ERROR_INPUT_UINPUT+=" (INPUT_UINPUT) compiled into your kernel"
		ERROR_INPUT_UINPUT+=" or loaded as a module to use this package."

		check_extra_config
	fi
}

src_install() {
	default
	newinitd "${FILESDIR}/keyd.initd" "keyd"
	mv "${D}/usr/share/doc/keyd" "${D}/usr/share/doc/${P}" || die
	docompress -x /usr/share/man/man1/keyd.1.gz
	docompress -x /usr/share/man/man1/keyd-application-mapper.1.gz
	insinto /etc/keyd
	doins "${FILESDIR}"/default.conf
}
