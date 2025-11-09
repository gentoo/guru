# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="A monospaced pixel font with a lo-fi, techy vibe"
HOMEPAGE="https://departuremono.com/"
SRC_URI="https://github.com/rektdeckard/${PN}/releases/download/v${PV}/DepartureMono-${PV}.zip"

S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~x86 ~amd64-linux ~x86-linux ~x64-macos"

BDEPEND="app-arch/unzip"

FONT_S="${S}/DepartureMono-${PV}"
FONT_SUFFIX="otf"
