# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit cmake edo flag-o-matic python-r1

EIGEN_COMMIT="1d8b82b0740839c0de7f1242a3585e3390ff5f33"

DESCRIPTION="Cross-platform, high performance ML inferencing and training accelerator"
HOMEPAGE="
	https://onnxruntime.ai
	https://github.com/microsoft/onnxruntime
"
SRC_URI="
	https://github.com/microsoft/onnxruntime/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/libeigen/eigen/-/archive/${EIGEN_COMMIT}/eigen-${EIGEN_COMMIT}.tar.bz2 ->
		eigen-3.4.0_p20250216.tar.bz2
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/abseil-cpp:=
	dev-libs/cpuinfo
	dev-libs/protobuf:=
	dev-libs/re2:=
	sci-ml/onnx[disableStaticReg]

	python? (
		${PYTHON_DEPS}
		dev-python/coloredlogs[${PYTHON_USEDEP}]
		dev-python/flatbuffers[${PYTHON_USEDEP}]
		>=dev-python/numpy-2[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/protobuf[${PYTHON_USEDEP}]
		dev-python/sympy[${PYTHON_USEDEP}]
	)
"
DEPEND="
	${RDEPEND}
	dev-cpp/ms-gsl
	dev-cpp/nlohmann_json
	dev-cpp/safeint
	dev-libs/boost
	dev-libs/date
	dev-libs/flatbuffers

	python? (
		dev-python/pybind11[${PYTHON_USEDEP}]
		sci-libs/dlpack
	)
"
BDEPEND="
	${PYTHON_DEPS}

	test? (
		dev-cpp/gtest

		python? ( dev-python/pytest[${PYTHON_USEDEP}] )
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-1.22.2-relax-the-dependency-on-flatbuffers.patch"
	"${FILESDIR}/${PN}-1.22.2-remove-the-absl-low_level_hash-target.patch"
	"${FILESDIR}/${PN}-1.23.2-fix-compilation-errors.patch"
	"${FILESDIR}/${PN}-1.23.2-use-system-libraries.patch"
)

CMAKE_USE_DIR="${S}/cmake"

src_configure() {
	# Python is used at build time unconditionally
	python_setup

	local mycmakeargs=(
		-Donnxruntime_BUILD_SHARED_LIB=on

		-Donnxruntime_BUILD_UNIT_TESTS=$(usex test)
		-Donnxruntime_ENABLE_PYTHON=$(usex python)

		# This is required until a newer version of Eigen3 comes out
		-DFETCHCONTENT_SOURCE_DIR_EIGEN3="${WORKDIR}/eigen-${EIGEN_COMMIT}"

		# This makes it possible for `find_path` to find the `onnx-ml.proto` file
		-DCMAKE_INCLUDE_PATH="$(python_get_sitedir)"

		-Wno-dev
	)

	append-ldflags -Wl,-z,noexecstack
	cmake_src_configure
}

# Adapted from `run_onnxruntime_tests` in `tools/ci_build/build.py`
python_test() {
	cd "${S}/cmake_build" || die
	epytest --pyargs \
		onnxruntime_test_python.py \
		onnxruntime_test_python_backend.py \
		onnxruntime_test_python_mlops.py \
		onnxruntime_test_python_sparse_matmul.py
}

src_test() {
	export GTEST_FILTER="*:-ActivationOpNoInfTest.Softsign:LayoutTransformationPotentiallyAddedOpsTests.OpsHaveLatestVersions"
	cmake_src_test

	if use python ; then
		python_test
	fi
}

# There is some custom logic in `setup.py`
python_install() {
	cd "${S}/cmake_build" || die
	edo ${EPYTHON} ../setup.py install \
		--prefix="${EPREFIX}/usr" \
		--root="${D}"

	libs=(
		"libonnxruntime.so.${PV}"
		"libonnxruntime_providers_shared.so"
	)
	for lib in "${libs[@]}"; do
		ln -fsr "${ED}/usr/$(get_libdir)/${lib}" "${D}/$(python_get_sitedir)/onnxruntime/capi/${lib}"
	done

	rm -rf "${D}/$(python_get_sitedir)"/*.egg-info
	python_optimize
}

src_install() {
	cmake_src_install

	if use python ; then
		python_foreach_impl python_install
	fi
}
