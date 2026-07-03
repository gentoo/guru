# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#upstream does not provide release tarballs/snapshots, using git-r3.
inherit git-r3

DESCRIPTION=""
HOMEPAGE="https://git.symlinx.net/pkgit/about"
LICENSE="GPL-2"
SLOT="0"

EGIT_REPO_URI="https://git.symlinx.net/pkgit"
EGIT_COMMIT="1.1.3"
KEYWORDS=""

RDEPEND="
	dev-vcs/git
	net-misc/curl
"
DEPEND="${RDEPEND}"
BDEPEND=""
