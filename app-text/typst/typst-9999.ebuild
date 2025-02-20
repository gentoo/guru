# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo shell-completion
inherit git-r3

DESCRIPTION="A markup-based typesetting system for the sciences"
HOMEPAGE="https://typst.app"
EGIT_REPO_URI="https://github.com/typst/typst.git"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 UoI-NCSA
	Unicode-3.0 ZLIB
"
SLOT="0"

RDEPEND="
	>=dev-libs/openssl-1.0.2o-r6:0=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-vcs/git
"

QA_FLAGS_IGNORED="usr/bin/typst"

DOCS=( README.md )

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_compile() {
	export GEN_ARTIFACTS="artifacts/"

	cargo_src_compile
}

src_install() {
	local ARTIFACTSDIR='crates/typst-cli/artifacts'
	cargo_src_install --path "${S}/crates/typst-cli"
	doman "${ARTIFACTSDIR}/${PN}"*.1
	dozshcomp "${ARTIFACTSDIR}/_${PN}"
	dofishcomp "${ARTIFACTSDIR}/${PN}.fish"
	newbashcomp "${ARTIFACTSDIR}/${PN}.bash" "${PN}"

	einstalldocs
}

src_test() {
	cargo_src_test --workspace
}
