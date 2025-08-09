# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.71.1"

CRATES="
	diff@0.1.13
	glob@0.3.2
	libc@0.2.174
	log@0.4.27
	pretty_assertions@1.4.1
	yansi@1.0.1
"

inherit cargo pam

DESCRIPTION="A memory safe implementation of sudo and su."
HOMEPAGE="https://github.com/trifectatechfoundation/sudo-rs"
SRC_URI="https://github.com/trifectatechfoundation/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+=" || ( Apache-2.0 MIT )"

SLOT="0"
KEYWORDS="~amd64"
IUSE="+pam su"

DEPEND="
	pam? ( sys-libs/pam )
"
RDEPEND="
	${DEPEND}
	virtual/editor
	!app-admin/sudo
	su? (
		sys-apps/shadow[-su]
		sys-apps/util-linux[-su]
	)
	pam? ( sys-auth/pambase )
"

DOCS=( README.md CHANGELOG.md )

src_install() {
	dobin "$(cargo_target_dir)/sudo" || die
	dobin "$(cargo_target_dir)/visudo" || die

	if use su ; then
		dobin "$(cargo_target_dir)/su" || die
	fi

	fowners 0:0 /usr/bin/sudo
	fperms 4755 /usr/bin/sudo
	fowners 0:0 /usr/bin/visudo
	fperms 4755 /usr/bin/visudo

	if use su ; then
		fowners 0:0 /usr/bin/su
		fperms 4755 /usr/bin/su
	fi

	if use su ; then
		newman docs/man/su.1.man su.1
	fi

	newman docs/man/sudo.8.man sudo.8
	newman docs/man/visudo.8.man visudo.8
	newman docs/man/sudoers.5.man sudoers.5

	if use pam ; then
		pamd_mimic system-auth sudo auth account session
		pamd_mimic system-auth sudo-i auth account session
	fi
}

pkg_postinst() {
	einfo "*******************"
	ewarn "Sudo-rs needs the sudoers configuration file."
	ewarn "The sudoers configuration file will be loaded from /etc/sudoers-rs if that file exists,"
	ewarn "otherwise the original /etc/sudoers location will be used."
}
