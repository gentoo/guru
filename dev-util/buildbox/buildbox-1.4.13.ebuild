# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake linux-info

DESCRIPTION="Suite of tools conforming to the Remote Execution and Workers API"
HOMEPAGE="https://buildgrid.gitlab.io/buildbox/buildbox/index.html"
SRC_URI="https://gitlab.com/BuildGrid/buildbox/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="casd fuse oci recc test tools"
REQUIRED_USE="
	^^ ( casd tools )
	fuse? ( casd )
	oci? ( tools )
"

DEPEND="
	dev-cpp/abseil-cpp:=
	dev-libs/openssl:=
	dev-libs/protobuf:=
	net-libs/grpc:=
	sys-apps/util-linux
	fuse? ( sys-fs/fuse:3= )
	oci? (
		dev-cpp/nlohmann_json
		net-misc/curl
	)
"

# FIXME: cmake doesn't catch this dependency during configure
DEPEND+="dev-cpp/nlohmann_json"

RDEPEND="${DEPEND}
	sys-apps/attr
	sys-apps/bubblewrap
	sys-apps/net-tools
	oci? ( app-containers/runc )
"

BDEPEND="
	dev-cpp/gtest
	dev-cpp/tomlplusplus
	sys-libs/libunwind
	net-dns/c-ares
	virtual/pkgconfig
	recc? ( virtual/zlib:= )
"

RESTRICT="!test? ( test )"

PATCHES=(
	# for musl libc
	"${FILESDIR}"/${P}-include-types.h.patch
)

pkg_setup() {
	if use fuse && use test; then
		CONFIG_CHECK="FUSE_FS"
		linux-info_pkg_setup
	elif use fuse; then
		CONFIG_CHECK="~FUSE_FS"
		linux-info_pkg_setup
	fi
}

src_configure() {
	local mycmakeargs=(
			# only accepts capital ON/OFF
			-DTOOLS=$(usex tools ON OFF)
			-DCASD=$(usex casd ON OFF)
			-DCASD_WRAP=$(usex casd ON OFF)
			-DCASUPLOAD_OCI=$(usex oci ON OFF)
			-DFUSE=$(usex fuse ON OFF)
			-DLOGSTREAMRECEIVER=$(usex tools ON OFF)
			-DLOGSTREAMTAIL=$(usex tools ON OFF)
			-DOCI=$(usex oci ON OFF)
			-DOUTPUTSTREAMER=$(usex tools ON OFF)
			-DRECC=$(usex recc ON OFF)
			-DREXPLORER=$(usex casd ON OFF)
			-DRUMBAD=$(usex tools ON OFF)
			-DRUN_BUBBLEWRAP=$(usex casd ON OFF)
			-DRUN_HOSTTOOLS=$(usex tools ON OFF)
			-DRUN_OCI=$(usex oci ON OFF)
			# bwrap on linux
			-DRUN_SYMLINK=$(usex casd bubblewrap OFF)
			-DRUN_USERCHROOT=OFF
			-DTREXE=$(usex tools ON OFF)
			-DWORKER=$(usex tools ON OFF)
			-DBUILD_MOSTLY_STATIC=OFF
			# Passes "-O1 -D_FORTIFY_SOURCE=2", which we already do
			-DHARDEN=OFF
			-DBUILD_SHARED_LIBS=ON
			)

		if use casd; then
			# manually specified variable with USE=-casd
			# QA Notice: One or more CMake variables were not used by the project:
			mycmakeargs+=( -DCASD_BUILD_BENCHMARK=OFF )
		fi

	cmake_src_configure
}

src_test() {
	local CMAKE_SKIP_TESTS=(
	)

	if use fuse; then
		# fuse: failed to open /dev/fuse: Permission denied
		addwrite "/dev/fuse"

		# fusermount3: mount failed: Operation not permitted
		# NOTE: only tested inside container with /dev/fuse mounted
		# FIXME: test on host
		CMAKE_SKIP_TESTS+=(
			casd_local_service_static_instance_tests
			casd_local_service_dynamic_instance_tests
			casd_local_service_remote_server_dynamic_instance_tests
			casd_local_service_remote_server_static_instance_tests
			casd_local_execution_service_tests
			casd_hybrid_execution_service_tests
			casd_hybrid_fallback_execution_service_tests_1
			casd_hybrid_fallback_execution_service_tests_2
			casd_hybrid_fallback_execution_service_tests_3
			fuse_*
		)
	fi

	cmake_src_test
}
