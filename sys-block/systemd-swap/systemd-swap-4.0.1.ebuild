# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info

DESCRIPTION="Script for creating swap space from zram swaps, swap files and swap partitions."
HOMEPAGE="https://github.com/Nefelim4ag/systemd-swap/"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Nefelim4ag/${PN}.git"
else
	SRC_URI="https://github.com/Nefelim4ag/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

CONFIG_CHECK="~ZRAM ~ZSWAP"

src_install() {
	emake PREFIX="${ED}" install
	keepdir /var/lib/systemd-swap
}
