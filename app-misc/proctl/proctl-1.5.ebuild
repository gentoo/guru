# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

EGIT_REPO_URI="https://github.com/kernaltrap8/proctl"
EGIT_COMMIT="v${PV}"

DESCRIPTION="small C program that can control processes"
HOMEPAGE="https://github.com/kernaltrap8/proctl"

LICENSE="GPL-3"
SLOT="0"
