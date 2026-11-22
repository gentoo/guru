# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
inherit python-single-r1

COMMIT="08064858578d9b262a2ed6cc3309b0cc1b13b999"

DESCRIPTION="XSane wrapper for GIMP 3.0 via CLI"
HOMEPAGE="https://yingtongli.me/git/gimp-xsanecli/"
SRC_URI="https://bugs.gentoo.org/attachment.cgi?id=955778 -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	media-gfx/gimp[${PYTHON_SINGLE_USEDEP}]
	media-gfx/xsane
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"

src_install() {
	# GIMP 3.0 looks for plugins in their own subdirectories
	local gimp_plugin_dir="/usr/$(get_libdir)/gimp/3.0/plug-ins/${PN}"

	exeinto "${gimp_plugin_dir}"
	newexe xsanecli.py "${PN}"

	python_fix_shebang "${ED}/${gimp_plugin_dir}/${PN}"

	# Use dodoc instead of einstalldocs for manual control
	dodoc README.md CONTRIBUTORS
}
