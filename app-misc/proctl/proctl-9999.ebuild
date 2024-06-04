# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == 9999  ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kernaltrap8/proctl"
	S="${WORKDIR}/${PN}-9999"
fi

DESCRIPTION="small C program that can control processes"
HOMEPAGE="https://github.com/kernaltrap8/proctl"

LICENSE="GPL-3"
SLOT="0"
