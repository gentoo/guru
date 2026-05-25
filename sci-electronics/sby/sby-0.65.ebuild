# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1

DESCRIPTION="Front-end for Yosys-based formal hardware verification flows"
HOMEPAGE="https://github.com/YosysHQ/sby"
SRC_URI="https://github.com/YosysHQ/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test yices2"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/click[${PYTHON_USEDEP}]
	')
	sci-electronics/yosys
	sci-mathematics/z3
	yices2? ( sci-mathematics/yices2 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/xmlschema[${PYTHON_USEDEP}]
		')
	)
"

src_test() {
	# Upstream tests race under parallel make (concurrent sqlite WAL access
	# to shared status_db). Force serial execution.
	emake -j1 -C tests test
}

src_install() {
	# Install Python modules to yosys shared directory
	insinto /usr/share/yosys/python3
	doins sbysrc/sby_*.py

	# Install sby_core.py with program prefix substitution
	sed -e 's|##yosys-program-prefix##|""|' \
		sbysrc/sby_core.py > "${T}/sby_core.py" || die
	doins "${T}/sby_core.py"

	# Create the sby launcher script with path and version substitutions
	# Use absolute path with EPREFIX because python-exec wrapper changes script location
	local syspath="sys.path += [\"${EPREFIX}/usr/share/yosys/python3\"]"
	sed -e "s|##yosys-sys-path##|${syspath}|" \
		-e "s|##yosys-release-version##|release_version = 'SBY ${PV}'|" \
		sbysrc/sby.py > "${T}/sby" || die
	python_newscript "${T}/sby" sby

	dodoc README.md
}
