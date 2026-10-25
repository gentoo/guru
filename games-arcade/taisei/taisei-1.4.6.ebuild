# Copyright 2019-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_14 )

inherit meson python-any-r1 xdg

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/taisei-project/taisei.git"
else
	# Auto-generated tarballs lacks submodules, all of which are taisei subrepos
	SRC_URI="https://github.com/taisei-project/taisei/releases/download/v${PV}/taisei-${PV}.tar.xz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Clone of the Touhou series, written in C using SDL/OpenGL/OpenAL"
HOMEPAGE="https://taisei-project.org/"
LICENSE="MIT CC-BY-4.0 CC0-1.0 public-domain"
SLOT="0"

IUSE="doc lto +mimalloc"

RDEPEND="
	dev-util/glslang
	media-libs/freetype:2
	media-libs/opusfile
	>=media-libs/libpng-1.5
	>=media-libs/libsdl3-3.2.0[opengl]
	media-libs/libwebp
	media-libs/opusfile
	app-arch/zstd
	virtual/zlib:=
	dev-libs/openssl:=
	>=dev-libs/libunibreak-6.1
	mimalloc? ( dev-libs/mimalloc:= )
"
# bug in dev-libs/cglm-0.9.3: https://github.com/taisei-project/taisei/issues/381
DEPEND="
	${RDEPEND}
	>=dev-libs/cglm-0.7.8
	!!~dev-libs/cglm-0.9.3
"
BDEPEND="
	>=dev-build/meson-1.8.0
	sys-devel/gettext
	${PYTHON_DEPS}
	doc? ( dev-python/docutils )
"

# BSD qsort_r(3) and Microsoft qsort_s(3) implicit declarations
# https://bugs.gentoo.org/941235
QA_CONFIG_IMPL_DECL_SKIP=(
	qsort_r
	qsort_s
)

src_prepare() {
	# Path patching needed also without USE=doc (COPYING etc.)
	sed -i "s/doc_path = join.*/doc_path = join_paths(datadir, \'doc\', \'${PF}\')/" \
		meson.build || die "Failed changing doc_path"

	# Remove blobs
	rm -f external/basis_universal/OpenCL/lib/*.lib \
		external/basis_universal/webgl_videotest/basis.wasm \
		external/basis_universal/webgl/transcoder/build/basis_transcoder.wasm \
		external/basis_universal/webgl/encoder/build/basis_encoder.wasm \
		|| die

	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature doc docs)
		$(meson_use lto b_lto)
		-Dallocator=$(usex mimalloc mimalloc libc)
		-Dstrip=false
		-Duse_libcrypto=enabled
	)
	meson_src_configure
}
