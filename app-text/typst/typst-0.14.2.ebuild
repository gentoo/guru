# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.89"

inherit cargo shell-completion

DESCRIPTION="A markup-based typesetting system for the sciences"
HOMEPAGE="https://typst.app"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/typst/typst.git"
else
	SRC_URI="
		https://github.com/${PN}/${PN}/archive/v${PV}/${P}.tar.gz
		https://github.com/odrling/typst/releases/download/v${PV}/typst-vendor.tar.xz -> ${P}-vendor.tar.xz
	"
	KEYWORDS="~amd64 ~arm64"
fi

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

if [[ ${PV} != 9999 ]]; then
	ECARGO_VENDOR="${WORKDIR}/vendor"
fi

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_prepare() {
	if [[ ${PV} != 9999 ]]; then
		# ignore git repo for typst-dev-assets when using a vendor tarball
		sed -i 's/^typst-dev-assets.*$/typst-dev-assets = "*"/' Cargo.toml || die
	fi

	default
}

src_compile() {
	if [[ ${PV} != 9999 ]]; then
		local GIT_HASH=$(gunzip < "${DISTDIR}/${P}.tar.gz" | git get-tar-commit-id)
		export TYPST_VERSION="${PV} (${GIT_HASH::8})"
	fi
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
