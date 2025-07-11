# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="LYGIA is a shader library of reusable functions."

HOMEPAGE="
https://lygia.xyz
https://github.com/patriciogonzalezvivo/lygia"
SRC_URI="https://codeload.github.com/patriciogonzalezvivo/lygia/tar.gz/refs/tags/${PV} -> ${P}.tar.gz"

LICENSE="Prosperity-3.0.0"
SLOT="0"
KEYWORDS="~amd64"

install_dir=/usr/include
pc_file=lygia.pc

src_prepare()
{
	default
	sed \
		-e "s|@INSTALL_DIR@|${install_dir%%/}/|g" \
		-e "s|@VERSION@|${PV}|g" \
		"${FILESDIR}/${pc_file}.in" > ${pc_file} || die "sed failed"
}

src_install()
{
	dodoc *.md
	rm -f *.md

	insinto ${install_dir}/${PN}
	doins -r *

	insinto /usr/lib64/pkgconfig
	doins ${pc_file}
}
