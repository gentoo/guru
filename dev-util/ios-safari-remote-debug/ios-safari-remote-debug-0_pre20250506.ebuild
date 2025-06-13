# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGIT_COMMIT="d73d1215b38abb82f64513f472fd75ee2b8224f5"

DESCRIPTION="A remote debugger for iOS Safari"
HOMEPAGE="https://git.gay/besties/ios-safari-remote-debug"
SRC_URI="
	https://git.gay/besties/ios-safari-remote-debug/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

S="${WORKDIR}/${PN}"

LICENSE="AGPL-3+ BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build
}

src_install() {
	dobin ios-safari-remote-debug

	default
}
