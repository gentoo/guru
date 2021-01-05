# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CONFIG_CHECK="~ZRAM ~ZSWAP"
PYTHON_COMPAT=( python3_{7..8} )

inherit linux-info python-any-r1

DESCRIPTION="Script for creating swap space from zram swaps, swap files and swap partitions."
HOMEPAGE="https://github.com/Nefelim4ag/systemd-swap/"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Nefelim4ag/${PN}.git"
else
	SRC_URI="https://github.com/Nefelim4ag/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	$(python_gen_any_dep '
		dev-python/python-systemd[${PYTHON_USEDEP}]
		dev-python/sysv_ipc[${PYTHON_USEDEP}]
	')
"

src_install() {
	default
	keepdir /var/lib/systemd-swap
}
