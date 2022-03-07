# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	bitflags-1.3.2
	deunicode-1.3.1
	getopts-0.2.21
	memchr-2.4.1
	pulldown-cmark-0.8.0
	unicase-2.6.0
	unicode-width-0.1.9
	version_check-0.9.4
"

inherit cargo

DESCRIPTION="Markdown to groff (man page) converter"
HOMEPAGE="https://gitlab.com/kornelski/mandown.git"
SRC_URI="
	https://gitlab.com/kornelski/mandown/-/archive/${PV}/mandown-${PV}.tar.bz2
	$(cargo_crate_uris)
"
LICENSE="
	|| ( Apache-2.0 MIT )
	|| ( MIT Unlicense )
	BSD
	MIT
"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/mandown"

src_install() {
	cargo_src_install
	dodoc README.md
}
