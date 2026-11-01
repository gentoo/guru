# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1

DESCRIPTION="Command-line tool used for the development of Graal projects"
HOMEPAGE="https://github.com/graalvm/mx"
SRC_URI="https://github.com/graalvm/mx/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
RDEPEND="${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
KEYWORDS="~amd64"

src_prepare() {
	default
	export SITE_PKG="$(python_get_sitedir)/${PN}"

	sed -e "s/\${PN}/${PN}/g" "${FILESDIR}/${PN}-$(ver_cut 1)-set-mxhome-to-share.in" > "${T}/${PN}-$(ver_cut 1)-set-mxhome-to-share.patch"
	eapply "${T}/${PN}-$(ver_cut 1)-set-mxhome-to-share.patch" || die "Failed to apply modified mx_home patch"
}

src_install() {
	python_moduleinto ${SITE_PKG}
	python_domodule src/

	python_moduleinto "/usr/share/${PN}"
	python_domodule mx.mx/

	insinto "/usr/share/${PN}"
	doins .mx_vcs_root
	doins -r ninja-toolchains/
	doins -r java/
	doins -r tests/
	keepdir "/usr/share/${PN}/mxbuild"
	fperms 0777 "/usr/share/${PN}/mxbuild"
	fperms -R 0777 "/usr/share/${PN}/java"

	cat <<- EOF > "${T}/mx-run.py" || die
		#!/usr/bin/env python
		import sys, runpy
		sys.path.insert(0, '${SITE_PKG}/src')
		runpy.run_module('mx', run_name='__main__')
	EOF
	python_newscript "${T}/mx-run.py" mx
}

pkg_postrm() {
	# mx itself may have created files inside shared directory outside of portage
	rm -rf "/usr/share/${PN}/mxbuild"
	rm -rf "/usr/share/${PN}/java"
}
