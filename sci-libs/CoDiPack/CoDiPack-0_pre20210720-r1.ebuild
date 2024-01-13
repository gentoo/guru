# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="ee2d80cc362f26879deead881c79523c113e9e6c"

DESCRIPTION='Fast gradient evaluation in C++ based on Expression Templates'
HOMEPAGE="
	https://github.com/SciCompKL/CoDiPack
	https://www.scicomp.uni-kl.de/software/codi/
"
SRC_URI="https://github.com/SciCompKL/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

KEYWORDS="~amd64"
LICENSE='GPL-3'
IUSE="doc tutorials" # examples mpi
SLOT="0/${PV}"

#DEPEND="mpi? ( sci-libs/MeDiPack )"
RDEPEND="${DEPEND}"
BDEPEND="doc? (
		app-text/doxygen[dot]
		dev-texlive/texlive-latex
	)
"

src_compile() {
	export CPP14=yes
#	use mpi && export MPI=yes && export MEDI_DIR="/usr/share/MeDiPack"
	use doc && emake doc
#	use examples && emake examples
	use tutorials && emake tutorials
}

src_install() {
	doheader -r include/*
#	exeinto "/usr/libexec/${PN}/examples"
#	use examples && doexe build/documentation/examples/*.exe
	exeinto "/usr/libexec/${PN}/tutorials"
#	use tutorials && doexe build/documentation/tutorials/*.exe
	use tutorials && doexe build/tutorial*.exe
	use doc && dodoc -r build/documentation/html
}
