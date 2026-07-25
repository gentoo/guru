# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	cc@1.3.0
	find-msvc-tools@0.1.9
	shlex@2.0.1
"

inherit cargo

DESCRIPTION="A compiler for the B Programming Language implemented in Crust"
HOMEPAGE="https://github.com/bext-lang/b"

GIT_COMMIT="078429a578202d8f6c4c667c780fc48f3711567f"
SRC_URI="
	https://github.com/bext-lang/b/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/masterwolf-git/b/raw/refs/heads/main/rust.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}-${GIT_COMMIT}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" || ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64"

src_prepare()
{
	cp "${WORKDIR}/Cargo.toml" "${S}/" || die
	cp "${WORKDIR}/Cargo.lock" "${S}/" || die
	cp "${WORKDIR}/build.rs" "${S}/"   || die
	default
}

src_test()
{

	mkdir -p build || die
	cp target/release/b build/b || die

	cargo_src_compile --bin btest
	einfo "Running btest matrix..."
	./target/release/btest || die "btest failed"
}

src_compile()
{
	cargo_src_compile --bin bgen
	einfo "Running bgen code generator..."
	./target/release/bgen || die "bgen execution failed"
	cargo_src_compile --bin b
}

src_install()
{
	cargo_src_install --bin b
}
