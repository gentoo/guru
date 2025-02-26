# Copyright 2025 Gentoo Developers
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 systemd

DESCRIPTION="bpftune uses BPF to auto-tune Linux systems"
HOMEPAGE="https://github.com/oracle/bpftune"
EGIT_REPO_URI="https://github.com/oracle/bpftune.git"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	dev-libs/libbpf
	sys-libs/libcap
	dev-libs/libnl
"
DEPEND="
	${RDEPEND}
	dev-util/bpftool
	llvm-core/clang
"

src_compile() {
	emake libdir="$(get_libdir)" srcdir
}

src_install() {
	dobin src/bpftune
	dolib.so src/libbpftune.so*

	exeinto "/usr/$(get_libdir)/bpftune"
	doexe src/tcp_buffer_tuner.so
	doexe src/route_table_tuner.so
	doexe src/neigh_table_tuner.so
	doexe src/sysctl_tuner.so
	doexe src/tcp_conn_tuner.so
	doexe src/netns_tuner.so
	doexe src/net_buffer_tuner.so
	doexe src/ip_frag_tuner.so

	systemd_dounit src/bpftune.service
}
