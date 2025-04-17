# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

inherit cargo shell-completion

DESCRIPTION="A cli utility for easily compressing and decompressing files and directories."
HOMEPAGE="https://github.com/ouch-org/ouch"
SRC_URI="https://github.com/ouch-org/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
DEPS_URI="https://github.com/freijon/${PN}/releases/download/${PV}/${P}-crates.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD MIT Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-arch/bzip2
	app-arch/bzip3
	app-arch/xz-utils
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/${PN}"
QA_PRESTRIPPED="usr/bin/${PN}"

src_compile() {
	local -x OUCH_ARTIFACTS_FOLDER=artifacts
	cargo_src_compile
}

src_install() {
	cargo_src_install

	doman artifacts/*.1

	newbashcomp "artifacts/${PN}.bash" "${PN}"
	dozshcomp "artifacts/_${PN}"
	dofishcomp "artifacts/${PN}.fish"
}
