# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools llvm toolchain-funcs

DESCRIPTION="Binary annotation compiler plugin and tools"
HOMEPAGE="https://nickc.fedorapeople.org"
SRC_URI="https://nickc.fedorapeople.org/${P}.tar.xz"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE="clang doc llvm test"

RDEPEND="
	app-arch/rpm
	dev-libs/elfutils
	sys-libs/binutils-libs

	clang? ( <sys-devel/clang-13:= )
	!clang? ( llvm? ( <sys-devel/llvm-13:= ) )
	llvm? (
		|| (
			sys-devel/llvm:11
			sys-devel/llvm:12
			sys-devel/llvm:13
		)
	)
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-fix-bashism.patch"
	"${FILESDIR}/${P}-demangle.h-path.patch"
)
REQUIRED_USE="clang? ( llvm )"
RESTRICT="!test? ( test )"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		if ! tc-is-gcc ; then
			eerror "${PN} is a gcc plugin. Please emerge using gcc as CC"
			die "use gcc"
		fi
	fi
}

src_prepare() {
	default
	sed -i 's|2.69|2.71|g' config/override.m4 || die

	if use llvm; then
		local llvmdir="$(get_llvm_prefix -d)"
		local llvm_plugindir
		llvm_plugindir="$(
			clang --print-search-dirs | gawk -e\
			'BEGIN { FS = ":" } /libraries/ { print gensub(" =","",1,$2) } END { }'
		)"
		einfo $llvm_plugindir

		sed -i "/^INCDIR.*/ s|$| -I${llvmdir}/include|" {llvm,clang}-plugin/Makefile.in || die
		sed -i "/^CLANG_LIBS.*/ s|$| -L${llvmdir}/$(get_libdir)|" clang-plugin/Makefile.in || die
		sed -i 's/print-seach-dirs/print-search-dirs/g' {llvm,clang}-plugin/Makefile.in || die
		sed -i "s|^PLUGIN_INSTALL_DIR =.*|PLUGIN_INSTALL_DIR = \$\{DESTDIR\}/$(realpath ${llvm_plugindir})|" {llvm,clang}-plugin/Makefile.in || die
	fi

	eautoreconf
}

src_configure() {
	local myconf=(
		--with-libelf
		--with-gcc-plugin-dir=$($(tc-getCC) -print-file-name=plugin)
		--without-debuginfod # we don't have it enabled, comes with elfutils
		$(use_with clang)
		$(use_with llvm)
		$(use_with test tests)
		$(use_with doc docs)
	)
	econf "${myconf[@]}"
}
