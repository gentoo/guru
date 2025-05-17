# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.74.0"

CRATES="
	diff@0.1.13
	glob@0.3.2
	libc@0.2.172
	log@0.4.27
	pretty_assertions@1.4.1
	yansi@1.0.1
"

inherit cargo pam

DESCRIPTION="A memory safe implementation of sudo"
HOMEPAGE="https://github.com/trifectatechfoundation/sudo-rs"
SRC_URI="https://github.com/trifectatechfoundation/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pam +man"

DEPEND="
	!app-admin/sudo
	pam? ( sys-libs/pam )
"
RDEPEND="
	${DEPEND}
	virtual/editor
	pam? ( sys-auth/pambase )
"
BDEPEND="
	man? ( virtual/pandoc )
"

REQUIRED_USE="
	?? ( pam )
"

DOCS=( README.md CHANGELOG.md )

src_compile() {
	cargo_src_compile || die
}

src_install() {
	dobin "target/${RUST_TARGET}/release/sudo" || die
	dobin "target/${RUST_TARGET}/release/visudo" || die

	fowners 0:0 /usr/bin/sudo || die
	fperms 4755 /usr/bin/sudo || die
	fowners 0:0 /usr/bin/visudo || die
	fperms 4755 /usr/bin/visudo || die

	if use man ; then
		pandoc docs/man/sudo.8.md -s -t man -o docs/man/sudo.8
		pandoc docs/man/visudo.8.md -s -t man -o docs/man/visudo.8

		doman docs/man/sudo.8
		doman docs/man/visudo.8
	fi

	pamd_mimic system-auth sudo auth account session
	pamd_mimic system-auth sudo-i auth account session
}

pkg_postinst() {
	einfo "*******************"
	ewarn "Sudo-rs needs the sudoers configuration file."
	ewarn "The sudoers configuration file will be loaded from /etc/sudoers-rs if that file exists,"
	ewarn "otherwise the original /etc/sudoers location will be used."
}
