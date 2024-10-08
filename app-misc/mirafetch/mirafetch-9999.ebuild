# Copyright 2024 demize
# Distributed under the terms of the GNU General Public License v2
# Autogenerated by pycargoebuild 0.13.3

EAPI=8

inherit cargo git-r3

DESCRIPTION="A Rust reimplementation of Hyfetch wih a focus on speed"
HOMEPAGE="https://github.com/ArgentumCation/mirafetch"
EGIT_REPO_URI="https://github.com/ArgentumCation/mirafetch.git"

LICENSE="EUPL-1.2"
# Dependent crate licenses
LICENSE+=" Apache-2.0 MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
RESTRICT="test" # upstream has no tests. unrestrict if it adds them
QA_FLAGS_IGNORED="usr/bin/mirafetch"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
