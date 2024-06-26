# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="fetch program written in pure C"
HOMEPAGE="https://github.com/kernaltrap8/tinyfetch"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kernaltrap8/tinyfetch"
	S="${WORKDIR}/${PN}-9999"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="+pci"

RDEPEND="
	pci? (
		sys-apps/pciutils
	)
"
DEPEND="${RDEPEND}"
