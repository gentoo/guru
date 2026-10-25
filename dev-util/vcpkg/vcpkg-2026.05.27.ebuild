# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
TOOL_TAG="2026-05-27"
DATA_TAG="2026.05.25"

inherit cmake

DESCRIPTION="C/C++ library manager from Microsoft"
HOMEPAGE="https://github.com/microsoft/vcpkg https://vcpkg.io"

SRC_URI="
	https://github.com/microsoft/vcpkg-tool/archive/refs/tags/${TOOL_TAG}.tar.gz -> ${PN}-tool-${TOOL_TAG}.tar.gz
	https://github.com/microsoft/vcpkg/archive/refs/tags/${DATA_TAG}.tar.gz -> ${PN}-data-${DATA_TAG}.tar.gz
"
S="${WORKDIR}/vcpkg-tool-${TOOL_TAG}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="telemetry"

RDEPEND="
	dev-libs/libfmt:=
	net-misc/curl[ssl]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-cpp/cmrc"

PATCHES=(
	"${FILESDIR}/${PN}-tool-${TOOL_TAG}-fix-includes.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DVCPKG_DEVELOPMENT_WARNINGS=OFF
		-DVCPKG_WARNINGS_AS_ERRORS=OFF
		-DVCPKG_BUILD_TLS12_DOWNLOADER=OFF
		-DVCPKG_BUILD_FUZZING=OFF
		-DVCPKG_EMBED_GIT_SHA=OFF
		-DVCPKG_ARTIFACTS_DEVELOPMENT=OFF
		-DVCPKG_OFFICIAL_BUILD=OFF
		# vcpkg-tool's custom cmake/Find*.cmake modules download  their own
		# copies of fmt/cmrc/curl from GitHub/curl.se by default, which happens in src_configure, however
		# in src configure there is no network access outside of SRC_URIs, resulting in failed to resolve hostname issues
		-DVCPKG_DEPENDENCY_EXTERNAL_FMT=ON
		-DVCPKG_DEPENDENCY_CMAKERC=ON
		-DVCPKG_LIBCURL_DLSYM=OFF
		# cmrc's hasn't been bumped in 3 years, so it
		# fails against CMake >=4.0 unless CMAKE_POLICY_VERSION_MINIMUM is explicitly set
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5
	)
	cmake_src_configure
}

src_install() {
	local vcpkg_data_dir="${WORKDIR}/vcpkg-${DATA_TAG}"

	local vcpkg_home="/usr/share/vcpkg"
	local vcpkg_libexec="/usr/libexec/vcpkg"

	exeinto "${vcpkg_libexec}"
	doexe "${BUILD_DIR}/vcpkg"

	insinto "${vcpkg_home}"
	doins "${vcpkg_data_dir}/.vcpkg-root"
	doins -r "${vcpkg_data_dir}"/{scripts,triplets}

	insinto /usr/bin
	newins - vcpkg <<-EOF
		#!/bin/sh
		exec "${EPREFIX}${vcpkg_libexec}/vcpkg" --vcpkg-root "${EPREFIX}${vcpkg_home}" "\$@"
	EOF
	fperms +x /usr/bin/vcpkg

	# Equivalent to --disable-metrics
	if ! use telemetry; then
		newins - vcpkg.disable_metrics <<<""
	fi

	dodoc "${vcpkg_data_dir}/README.md"
}

pkg_postinst() {
	elog "Ports registry is not bundled; vcpkg fetches it on demand."
	if use telemetry; then
		elog "Telemetry is ENABLED. Rebuild with USE=-telemetry to disable."
	else
		elog "Telemetry is DISABLED (vcpkg.disable_metrics installed)."
	fi
}
