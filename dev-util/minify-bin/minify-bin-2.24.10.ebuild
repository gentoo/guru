# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

BASE_SRC_URI="https://github.com/tdewolff/minify/releases/download/v${PV}/minify_linux_@arch@.tar.gz"

DESCRIPTION="Minifier package that provides HTML5, CSS3, JS, JSON, SVG, and XML minifiers."
HOMEPAGE="https://go.tacodewolff.nl/minify"
SRC_URI="
	amd64? ( ${BASE_SRC_URI//@arch@/amd64} -> minify_linux_amd64-${PV}.tar.gz )
	arm64? ( ${BASE_SRC_URI//@arch@/arm64} -> minify_linux_arm64-${PV}.tar.gz )
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

QA_PRESTRIPPED=usr/bin/minify

src_install() {
	dobin minify
}
