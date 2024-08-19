# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Soothing port creation tool for the high-spirited!"
HOMEPAGE="https://github.com/catppuccin/whiskers"
SRC_URI="https://github.com/catppuccin/whiskers/releases/download/v${PV}/whiskers-x86_64-unknown-linux-gnu -> ${P}"
S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="usr/bin/whiskers"

src_install() {
	newbin "${DISTDIR}"/${P} whiskers
}
