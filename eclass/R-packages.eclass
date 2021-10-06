# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit eutils optfeature toolchain-funcs

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install pkg_postinst

SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"
HOMEPAGE="https://cran.r-project.org/package=${PN}"

SLOT="0"

DEPEND="dev-lang/R"
RDEPEND="${DEPEND}"

dodocrm() {
	if [ -e "${1}" ]; then
		dodoc -r "${1}"
		rm -rf "${1}" || die
	fi
}

R-packages_src_unpack() {
	unpack ${A}
	if [[ -d "${PN//_/.}" ]] && [[ ! -d "${P}" ]]; then
		mv "${PN//_/.}" "${P}" || die
	fi
}

R-packages_src_prepare() {
	rm -f LICENSE || die
	default
}

R-packages_src_compile() {
	MAKEFLAGS="AR=$(tc-getAR) CFLAGS=${CFLAGS// /\\ } CXXFLAGS=${CXXFLAGS// /\\ } FFLAGS=${FFLAGS// /\\ } FCFLAGS=${FCFLAGS// /\\ } LDFLAGS=${LDFLAGS// /\\ }" R CMD INSTALL . -l "${WORKDIR}" "--byte-compile" || die
}

R-packages_src_install() {
	cd "${WORKDIR}/${PN//_/.}" || die

	dodocrm examples || die
	#dodocrm DESCRIPTION || die #keep this
	dodocrm NEWS.md || die
	dodocrm README.md || die
	dodocrm html || die

	if [ -e doc ]; then
		if [ -e doc/html ]; then
			docinto "${DOCSDIR}/html"
			dodoc -r doc/*.html
			rm -r doc/*.html || die
			docompress -x "${DOCSDIR}/html"
		fi

		docinto "${DOCSDIR}"
		dodoc -r doc/.
		rm -r doc || die
	fi

	insinto "/usr/$(get_libdir)/R/site-library"
	doins -r "${WORKDIR}/${PN//_/.}"
}

R-packages_pkg_postinst() {
	if [ -v SUGGESTED_PACKAGES ]; then
		optfeature "having the upstream suggested packages" "${SUGGESTED_PACKAGES}"
	fi
}
