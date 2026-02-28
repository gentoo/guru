# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson-multilib

DESCRIPTION="A custom shader language called ReShade FX"
HOMEPAGE="https://github.com/crosire/reshade"
SRC_URI="https://github.com/crosire/reshade/archive/v${PV}.tar.gz -> reshade-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

DEPEND=">=dev-util/spirv-headers-1.2"
RDEPEND=""
BDEPEND="${DEPEND}"

S="${WORKDIR}/reshade-${PV}"

PATCHES=(
	"${FILESDIR}/${P}-gcc.patch"
)

multilib_src_configure() {
	# Create meson.build file
	# meson init -n ReShadeFX --version 4.8.2 $(ls -1 source/effect_*.cpp | xargs)
	# meson rewrite target ReShadeFX rm_target
	# meson rewrite target --type shared_library ReShadeFX add_target $(ls -1 source/effect_*.cpp | xargs)
	cat > "${S}/meson.build" <<-EOF
	project('${PN}', ['cpp'], default_options : ['cpp_std=c++20'], version : '${PV}', meson_version : '>= 0.50')
	
	sources = [
	  'source/effect_codegen_glsl.cpp',
	  'source/effect_codegen_hlsl.cpp',
	  'source/effect_codegen_spirv.cpp',
	  'source/effect_expression.cpp',
	  'source/effect_lexer.cpp',
	  'source/effect_parser_exp.cpp',
	  'source/effect_parser_stmt.cpp',
	  'source/effect_preprocessor.cpp',
	  'source/effect_symbol_table.cpp',
	]
	
	headers = [
	  'source/effect_codegen.hpp',
	  'source/effect_expression.hpp',
	  'source/effect_lexer.hpp',
	  'source/effect_module.hpp',
	  'source/effect_parser.hpp',
	  'source/effect_preprocessor.hpp',
	  'source/effect_symbol_table.hpp',
	  'source/effect_token.hpp',
	]
	
	headers_install_dir = 'reshade'
	
	# Shared lib
	out_lib = shared_library('ReShadeFX', sources, include_directories: [ '/usr/include/spirv/unified1' ], install: true)
	
	# pkgconfig
	pkg = import('pkgconfig')
	pkg.generate(out_lib, subdirs: headers_install_dir, description: '${DESCRIPTION}')
	
	# Headers
	install_headers(headers, subdir: headers_install_dir)
	EOF

	meson_src_configure
}

multilib_src_install() {
	meson_src_install
}
