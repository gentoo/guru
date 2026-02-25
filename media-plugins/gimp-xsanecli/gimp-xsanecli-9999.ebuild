# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Match the versions GIMP 3.0 supports
PYTHON_COMPAT=( python3_{11..14} )

inherit git-r3 python-single-r1

DESCRIPTION="XSane wrapper for GIMP 3.0 via CLI"
HOMEPAGE="https://yingtongli.me/git/gimp-xsanecli/"
EGIT_REPO_URI="https://yingtongli.me/git/gimp-xsanecli/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

# This ensures exactly one python_single_target_* is set
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# RDEPEND Explanation:
# 1. ${PYTHON_DEPS}: Pulls in the selected python interpreter
# 2. media-gfx/gimp[${PYTHON_SINGLE_USEDEP}]: Enforces that GIMP
#    has the SAME python_single_target enabled as this plugin.
# 3. pygobject: Needs the standard PYTHON_USEDEP because it is
#    a multi-target (python-r1) package.
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
	# GIMP 3.0 requires each plugin in a subfolder of the same name
	local gimp_plugin_dir="/usr/$(get_libdir)/gimp/3.0/plug-ins/${PN}"

	exeinto "${gimp_plugin_dir}"
	# Change 'gimp-xsanecli.py' to 'xsanecli.py'
	newexe xsanecli.py "${PN}"

	python_fix_shebang "${ED}/${gimp_plugin_dir}/${PN}"

	dodoc README.md CONTRIBUTORS
}
