# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs

DESCRIPTION="General purpose C++ library and tools"
HOMEPAGE="https://www.scalasca.org/scalasca/software/cube-4.x"
SRC_URI="https://apps.fz-juelich.de/scalasca/releases/cube/${PV}/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE_CUBELIB_STRATEGY="
	+cubelib_strategy_keepall
	cubelib_strategy_preload
	cubelib_strategy_manual
	cubelib_strategy_lastn
"
IUSE="R ${IUSE_CUBELIB_STRATEGY}"

RDEPEND="
	sys-libs/binutils-libs
	sys-libs/zlib
	R? (
		dev-lang/R
		dev-R/Rcpp
		dev-R/RInside
	)
"
DEPEND="
	${RDEPEND}
	dev-cpp/gtest
"
BDEPEND="
	sys-devel/flex
	app-alternatives/yacc
"

REQUIRED_USE="^^ ( ${IUSE_CUBELIB_STRATEGY/+/} )"

src_prepare() {
	tc-export CC CXX AR F77 FC CPP

	cat > build-config/common/platforms/platform-backend-user-provided <<-EOF || die
	CC=${CC}
	CXX=${CXX}
	FC=${FC}
	F77=${F77}
	CPP=${CPP}
	CXXCPP=${CPP}
	CC_FOR_BUILD=${CC}
	CXX_FOR_BUILD=${CXX}
	FC_FOR_BUILD=${FC}
	F77_FOR_BUILD=${F77}
	CFLAGS_FOR_BUILD=${CFLAGS}
	CXXFLAGS_FOR_BUILD=${CXXFLAGS}
	FFLAGS_FOR_BUILD=${FFLAGS}
	FCFLAGS_FOR_BUILD=${FCFLAGS}
	LDFLAGS_FOR_BUILD=${LDFLAGS}
	CPPFLAGS_FOR_BUILD=${CPPFLAGS}
	EOF

	rm -r vendor/googletest || die
	default
	eautoreconf
}

src_configure() {
	use cubelib_strategy_keepall && strategy="keepall"
	use cubelib_strategy_preload && strategy="preload"
	use cubelib_strategy_manual && strategy="manual"
	use cubelib_strategy_lastn && strategy="lastn"

	local myconf=(
		--disable-platform-mic
		--with-compression=full
		--with-custom-compilers
		--with-strategy="${strategy}"
		--with-system-parser
		$(use_with R cube_dump_r)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	mv "${ED}/usr/share/doc/cubelib/example" "${ED}/usr/share/doc/${PF}/" || die
	rm -r "${ED}/usr/share/doc/cubelib" || die
	dodoc OPEN_ISSUES README
	docompress -x "/usr/share/doc/${PF}/example"
	find "${ED}" -name '*.a' -delete || die
	find "${ED}" -name '*.la' -delete || die
}
