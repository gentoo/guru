# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

BASE_SRC_URI="https://github.com/PataphysicalSociety/soupault/releases/download/${PV}/soupault-${PV}-linux-@arch@.tar.gz"

DESCRIPTION="Static website generator based on HTML rewriting"
HOMEPAGE="https://soupault.net"
SRC_URI="
	amd64? ( ${BASE_SRC_URI//@arch@/x86_64} )
	arm64? ( ${BASE_SRC_URI//@arch@/aarch64} )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="!www-apps/soupault"

src_unpack() {
	default

	# The extracted top-level dir is named the same as the archive itself
	# (suffixed with "x86_64"/"aarch64"); dropping it lets us keep the default
	# `${S}`.
	mv "$(basename "${A}" '.tar.gz')" "${P}"
}

src_install() {
	dobin soupault
}
