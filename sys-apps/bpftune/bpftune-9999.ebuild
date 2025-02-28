# Copyright 2025 Gentoo Developers
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 systemd linux-info autotools

DESCRIPTION="bpftune uses BPF to auto-tune Linux systems"
HOMEPAGE="https://github.com/oracle/bpftune"
EGIT_REPO_URI="https://github.com/oracle/bpftune.git"

LICENSE="GPL-2"
SLOT="0"
BDEPEND="
	dev-util/bpftool
	dev-util/pahole
	llvm-core/clang
"
DEPEND="
	dev-libs/libbpf
	sys-libs/libcap
	dev-libs/libnl
"

pkg_setup() {
	CONFIG_CHECK="DEBUG_INFO_BTF"
	check_extra_config
}

src_install() {
	default
	systemd_dounit src/bpftune.service
}
