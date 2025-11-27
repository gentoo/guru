# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
inherit bash-completion-r1 cmake python-any-r1

declare -A submodules
submodules["src/runtime_src/aie-rt"]=https://github.com/Xilinx/aie-rt.git@a8b0667133ea2851ce27793a1796c5968226d9af
submodules["src/runtime_src/core/common/aiebu"]=https://github.com/Xilinx/aiebu.git@9065273e0c0a4ac5930fff904ac245cf38dd3087
submodules["src/runtime_src/core/common/elf"]=https://github.com/serge1/ELFIO.git@f849001fc229c2598f8557e0df22866af194ef98

DESCRIPTION="Runtime for AIE and FPGA based platforms"
HOMEPAGE="https://github.com/Xilinx/XRT"

MGS_HASH=554d75e924ed621f23d077b0495c247c329bc770
MGS=markdown_graphviz_svg
MGS_PY=${MGS}-${MGS_HASH:0:8}.py

if [[ ${PV} == 999999 ]] ; then
	EGIT_REPO_URI="https://github.com/Xilinx/XRT.git"
	EGIT_SUBMODULES=(
		src/runtime_src/aie-rt
		src/runtime_src/core/common/aiebu
		src/runtime_src/core/common/elf
	)
	inherit git-r3
else
	SRC_URI="
		https://github.com/Xilinx/XRT/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		https://raw.githubusercontent.com/Tanami/markdown-graphviz-svg/${MGS_HASH}/src/${MGS}/${MGS}.py -> ${MGS_PY}
	"
	for k in "${!submodules[@]}"; do
		git_url="${submodules[$k]%@*}"
		commit_hash="${submodules[$k]#*@}"
		url_prefix="${git_url%.git}"
		SRC_URI+=" ${url_prefix}/archive/${commit_hash}.tar.gz -> ${url_prefix##*/}-${commit_hash:0:8}.tar.gz";
	done

	KEYWORDS="~amd64"
	S="${WORKDIR}/XRT-${PV}"
fi

LICENSE="Apache-2.0"
SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/abseil-cpp:=
	dev-debug/systemtap
	dev-libs/boost:=
	dev-libs/openssl:=
	dev-libs/protobuf:=
	sys-apps/util-linux
"

DEPEND="
	${RDEPEND}
	dev-libs/cxxopts
	dev-libs/opencl-icd-loader
	dev-libs/rapidjson
	dev-util/opencl-headers
	x11-libs/libdrm
"

BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep "
		dev-python/jinja2[\${PYTHON_USEDEP}]
		dev-python/markdown[\${PYTHON_USEDEP}]
		dev-python/pybind11[\${PYTHON_USEDEP}]
		dev-python/pyyaml[\${PYTHON_USEDEP}]
	")
"

PATCHES=(
	"${FILESDIR}"/${PN}-202520.2.20.172-modern-protobuf.patch
)

python_check_deps() {
	python_has_version -b "dev-python/jinja2[${PYTHON_USEDEP}]" && \
	python_has_version -b "dev-python/markdown[${PYTHON_USEDEP}]" && \
	python_has_version -b "dev-python/pybind11[${PYTHON_USEDEP}]" && \
	python_has_version -b "dev-python/pyyaml[${PYTHON_USEDEP}]"
}

src_prepare() {
	if [[ ${PV} != 999999 ]] ; then
		for k in $(printf '%s\n' "${!submodules[@]}" | sort); do
			git_url="${submodules[$k]%@*}"
			commit_hash="${submodules[$k]#*@}"
			url_prefix="${git_url%.git}"
			rm -r "$k" || die
			ln -s "${WORKDIR}/${url_prefix##*/}-${commit_hash}" "$k" || die
		done
	fi

	pushd "src/runtime_src/core/common/aiebu" || die
	eapply "${FILESDIR}"/aiebu-no-downloads.patch
	popd || die

	sed -e 's/-Werror//' -i src/runtime_src/core/common/aiebu/cmake/linux.cmake || die

	# Enable <CL/cl_icd.h> instead of <ocl_icd.h>
	sed -e "/OPENCL_ICD_LOADER/c #if 1" \
		-i src/runtime_src/xocl/api/icd/ocl_icd_bindings.h \
		-i src/runtime_src/xocl/api/icd/ocl_icd_bindings.cpp || die

	# template for isa.h is damaged in git, skip regeneration
	# Bug: https://github.com/Xilinx/aiebu/issues/144
	sed -e '/BYPRODUCTS .*isa\.h/d' \
		-i src/runtime_src/core/common/aiebu/specification/aie2ps/CMakeLists.txt || die

	sed -e "s/set (XRT_UPSTREAM 0)/set (XRT_UPSTREAM 1)/" -i src/CMake/settings.cmake || die

	sed -e "s|\${XRT_INSTALL_DIR}/share/doc|\${CMAKE_INSTALL_DOCDIR}|" -i src/CMake/changelog.cmake || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DPython3_EXECUTABLE="${PYTHON}"
		-DSPEC_TOOL_DEPS_DOWNLOADED=ON
		-DXRT_ENABLE_WERROR=OFF
		-DXRT_NPU=ON
	)
	[[ ${PV} != 999999 ]] && mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_Git=ON )

	cmake_src_configure

	ln -s "${DISTDIR}/${MGS_PY}" \
		"${BUILD_DIR}"/src/runtime_src/core/common/aiebu/specification/${MGS}.py || die
}

src_test() {
	DESTDIR=. cmake_build install
	cmake_src_test
}

src_install() {
	cmake_src_install

	rm -r "${ED}"/usr/{license,version.json} || die
	rm -r "${ED}"/usr/share/completions || die

	newbashcomp "${S}/src/runtime_src/core/tools/xbutil2/xbutil-bash-completion" xrt-smi
}
