# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3
EGIT_REPO_URI="https://github.com/AdelKS/QuantumResolver.git"

DESCRIPTION="A WIP portage dependency resolver"
HOMEPAGE="https://github.com/AdelKS/QuantumResolver"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	>=dev-build/meson-0.63
	dev-libs/libfmt
"
