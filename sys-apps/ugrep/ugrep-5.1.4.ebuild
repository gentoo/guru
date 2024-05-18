# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

DESCRIPTION="A fast, drop-in replacement for GNU grep"
HOMEPAGE="https://ugrep.com/"
SRC_URI="https://github.com/Genivia/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="7zip brotli boost bzip3 cpu_flags_arm_neon cpu_flags_x86_avx2 cpu_flags_x86_sse2 +lzma lz4 +mmap +pcre2 +zlib zstd"

COMMON_DEPEND="
	brotli? ( app-arch/brotli )
	boost? ( dev-libs/boost )
	bzip3? ( app-arch/bzip3 )
	lz4? ( app-arch/lz4 )
	lzma? ( app-arch/xz-utils )
	pcre2? ( dev-libs/libpcre2 )
	zlib? ( sys-libs/zlib )
	zstd? ( app-arch/zstd )
"

RDEPEND="${COMMON_DEPEND}"

DEPEND="
	${COMMON_DEPEND}
	virtual/pkgconfig"

src_configure() {
	local myeconfargs=(
		$(usev !cpu_flags_arm_neon '--disable-neon')
		$(usev !cpu_flags_x86_avx2 '--disable-avx2')
		$(usev !cpu_flags_x86_sse2 '--disable-sse2')

		$(use_enable 7zip)
		$(use_enable mmap)

		$(use_with brotli)
		$(use_with bzip3)
		$(use_with pcre2)
		$(use_with lzma)
		$(use_with lz4)
		$(use_with zlib)
		$(use_with zstd)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default
	dobashcomp "${S}"/completions/bash/*
	dofishcomp "${S}"/completions/fish/*
	dozshcomp "${S}"/completions/zsh/_*
}

src_test() {
	# emake check is run first by default in Portage but
	# that doesn't actually run the tests, emake test does
	emake test
}
