# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#upstream does not provide release tarballs/snapshots, using git-r3.
inherit git-r3

DESCRIPTION="pkgit is an unconventional package manager designed to compile & install packages directly from their git repository."
HOMEPAGE="https://git.symlinx.net/pkgit/about"
LICENSE="GPL-2"
SLOT="0"

EGIT_REPO_URI="https://git.symlinx.net/pkgit"
EGIT_COMMIT="1.1.3"
EGIT_CLONE_TYPE="mirror"
KEYWORDS=""
