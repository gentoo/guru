# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-module

DESCRIPTION="Create fixup commits for topic branches"
HOMEPAGE="https://github.com/torbiak/git-autofixup"
SRC_URI="https://github.com/torbiak/git-autofixup/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-vcs/git-1.7.4
"
BDEPEND="
	test? (
		${RDEPEND}
	)
"
