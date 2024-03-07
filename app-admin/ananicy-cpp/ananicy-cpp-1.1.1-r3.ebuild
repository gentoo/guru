# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Ananicy rewritten in C++ for much lower CPU and memory usage"
HOMEPAGE="https://gitlab.com/ananicy-cpp/ananicy-cpp"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bpf clang systemd"
REQUIRED_USE="
	bpf? ( clang )
"

SRC_URI="https://gitlab.com/ananicy-cpp/ananicy-cpp/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

RDEPEND="
	!app-admin/ananicy
	>=dev-cpp/nlohmann_json-3.9
	>=dev-libs/libfmt-8
	>=dev-libs/spdlog-1.9
	bpf? (
		 dev-libs/elfutils
		 dev-libs/libbpf
		 dev-util/bpftool
	)
	systemd? ( sys-apps/systemd )
"

DEPEND="
	>=dev-build/cmake-3.17
	clang? ( >=sys-devel/clang-10 )
	${RDEPEND}
"

PATCHES=(
	"${FILESDIR}/${P}-remove-debug-flags.patch"
)

pkg_setup() {
	if use bpf ; then
		CONFIG_CHECK+="~BPF ~BPF_EVENTS ~BPF_SYSCALL ~HAVE_EBPF_JIT"
	fi
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_SYSTEMD=$(usex systemd)
		-DUSE_BPF_PROC_IMPL=$(usex bpf)
		-DUSE_EXTERNAL_FMTLIB=ON
		-DUSE_EXTERNAL_JSON=ON
		-DUSE_EXTERNAL_SPDLOG=ON
		-DVERSION=${PV}
	)

	if use clang; then
		local version_clang=$(clang --version 2>/dev/null | grep -F -- 'clang version' | awk '{ print $3 }')
		[[ -n ${version_clang} ]] && version_clang=$(ver_cut 1 "${version_clang}")
		[[ -z ${version_clang} ]] && die "Failed to read clang version!"
		CC=${CHOST}-clang-${version_clang}
		CXX=${CHOST}-clang++-${version_clang}

		if use bpf ; then
			mycmakeargs+=( -DBPF_BUILD_LIBBPF=OFF )
		fi
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install

	if ! use systemd ; then
		doinitd "${FILESDIR}/${PN}.initd"
	fi

	keepdir /etc/ananicy.d
}
