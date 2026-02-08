# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop flag-o-matic toolchain-funcs

DESCRIPTION="Head tracking software for MS Windows, Linux, and Apple OSX"
HOMEPAGE="https://github.com/opentrack/opentrack"

FUSION_PV="1.2.11"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/opentrack/opentrack.git"
else
	COMMIT=2d3ab7a61d2514ce51c9656908d33465a788763e
	SRC_URI="https://github.com/opentrack/opentrack/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/opentrack-${COMMIT}"
fi
SRC_URI+=" https://github.com/xioTechnologies/Fusion/archive/v${FUSION_PV}.tar.gz -> Fusion-${FUSION_PV}.tar.gz"

LICENSE="ISC MIT"
SLOT="0"
IUSE="neuralnet opencv openmp wine"
REQUIRED_USE="neuralnet? ( openmp opencv )"

DEPEND="
	dev-libs/libevdev
	dev-libs/libusb:1
	dev-qt/qtbase:6[gui,network,widgets]
	sys-process/procps:=
	x11-libs/libX11
	neuralnet? ( sci-libs/onnxruntime-bin )
	opencv? ( media-libs/opencv:= )
	wine? ( virtual/wine )
"
RDEPEND="${DEPEND}"

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

src_prepare() {
	# work around hard-coded docs path
	sed -e 's#share/doc/opentrack#share/doc/'${PF}'#g' \
		-i cmake/*.cmake || die

	cmake_src_prepare
}

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	else
		unpack ${P}.tar.gz
	fi
	unpack Fusion-${FUSION_PV}.tar.gz
}

src_configure() {
	use openmp && append-cxxflags -fopenmp && append-ldflags -fopenmp

	local mycmakeargs=(
		$(cmake_use_find_package neuralnet ONNXRuntime)
		$(cmake_use_find_package opencv OpenCV)
		$(cmake_use_find_package openmp OpenMP)

		# disconnect the build from external Fusion sources
		-DFETCHCONTENT_SOURCE_DIR_AHRSFUSION="${WORKDIR}/Fusion-${FUSION_PV}"
	)

	# opentrack overwrites emerge cflags unconditionally: we can prevent
	# that by pretending they've already been set
	mycmakeargs+=(
		-D__otr_compile_flags_set=TRUE
	)

	# HACK: "/opt/opentrack" allows its wine components to be visible in
	# Valve's pressure-vessel which replaces /usr with the container runtime
	use wine && mycmakeargs+=(
		-DCMAKE_INSTALL_PREFIX=/opt/opentrack
		-DOPENTRACK_WINE_ARCH="-m64"
		-DSDK_WINE=$(usex wine ON OFF)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	use wine && dosym -r /opt/opentrack/bin/opentrack /usr/bin/opentrack

	newicon gui/images/opentrack.png opentrack.png
	make_desktop_entry /usr/bin/opentrack OpenTrack /usr/share/pixmaps/opentrack.png Utility
}
