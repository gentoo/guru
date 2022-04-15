# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: R-packages.eclass
# @AUTHOR:
# André Erdmann <dywi@mailerd.de>
# Denis Dupeyron <calchan@gentoo.org>
# Benda Xu <heroxbd@gentoo.org>
# Alessandro Barbieri <lssndrbarbieri@gmail.com>
# @BLURB: eclass to build R packages
# @MAINTAINER:
# Alessandro Barbieri <lssndrbarbieri@gmail.com>
# @SUPPORTED_EAPIS: 7

inherit eutils optfeature toolchain-funcs

case ${EAPI} in
	7) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

EXPORT_FUNCTIONS src_unpack src_prepare src_configure src_compile src_install pkg_postinst

SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"
HOMEPAGE="https://cran.r-project.org/package=${PN}"

SLOT="0"

DEPEND="dev-lang/R"
RDEPEND="${DEPEND}"
BDEPEND="sys-apps/pkgcore"

# @FUNCTION: _movelink
# @INTERNAL
# @USAGE: [<source> <dest>]
# @DESCRIPTION:
# <dest> will contain symlinks to everything in <source>
_movelink() {
	if [ -e "${1}" ]; then
		local rp1="$(realpath ${1})" || die
		mv "${rp1}" "${2}" || die
		cp -rsf "${2}" "${rp1}" || die
	fi
}

# @FUNCTION: R-packages_src_unpack
# @DESCRIPTION:
# function to unpack R packages into the right folder
R-packages_src_unpack() {
	unpack ${A}
	if [[ -d "${PN//_/.}" ]] && [[ ! -d "${P}" ]]; then
		mv "${PN//_/.}" "${P}" || die
	fi
}

# @FUNCTION: R-packages_src_prepare
# @DESCRIPTION:
# function to remove unwanted files from the sources
R-packages_src_prepare() {
	rm -f LICENSE || die
	default
}

# @FUNCTION: R-packages_src_configure
# @DESCRIPTION:
# dummy function to disable configure
R-packages_src_configure() { :; }

# @FUNCTION: R-packages_src_compile
# @DESCRIPTION:
# function that will pass some environment variables to R and then build/install the package
R-packages_src_compile() {
	MAKEFLAGS=" \
		${MAKEFLAGS// /\\ } \
		AR=$(tc-getAR) \
		CC=$(tc-getCC) \
		CPP=$(tc-getCPP) \
		CXX=$(tc-getCXX) \
		FC=$(tc-getFC) \
		LD=$(tc-getLD) \
		NM=$(tc-getNM) \
		RANLIB=$(tc-getRANLIB) \
		CFLAGS=${CFLAGS// /\\ } \
		CPPFLAGS=${CPPFLAGS// /\\ } \
		CXXFLAGS=${CXXFLAGS// /\\ } \
		FFLAGS=${FFLAGS// /\\ } \
		FCFLAGS=${FCFLAGS// /\\ } \
		LDFLAGS=${LDFLAGS// /\\ } \
		MAKEOPTS=${MAKEOPTS// /\\ } \
	" \
	R CMD INSTALL . -l "${WORKDIR}" "--byte-compile" || die
}


# @FUNCTION: R-packages_src_install
# @DESCRIPTION:
# function to move the files in the right folders
# documentation and examples to docsdir, symlinked back to R site-library (to allow access from within R)
# everything else to R site-library
R-packages_src_install() {
	pushd "${WORKDIR}/${PN//_/.}" || die

	local DOCS_DIR="${ED}/usr/share/doc/${PF}"

	mkdir -p "${DOCS_DIR}" || die

	for i in NEWS.md README.md DESCRIPTION examples ; do
		_movelink "${i}" "${DOCS_DIR}/${i}" || die
	done

	if [ -e html ]; then
		_movelink html "${DOCS_DIR}/html" || die
		docompress -x "${DOCS_DIR}/html"
	fi
	if [ -e doc ]; then
		pushd doc || die
		for i in * ; do
			_movelink "${i}" "${DOCS_DIR}/${i}" || die
		done
		popd || die
	fi
	if [ -e doc/html ]; then
		docompress -x "${DOCS_DIR}/html"
	fi
	docompress -x "${DOCS_DIR}"

	insinto "/usr/$(get_libdir)/R/site-library"
	doins -r "${WORKDIR}/${PN//_/.}"
}

# @FUNCTION: R-packages_pkg_postinst
# @DESCRIPTION:
# function that will prompt to install the suggested packages if they exist
R-packages_pkg_postinst() {
	if [ -v SUGGESTED_PACKAGES ]; then
		for p in ${SUGGESTED_PACKAGES} ; do
			pexist=$(pquery -n1 "${p}" 2>/dev/null) || die
			if [ -n "${pexist}" ]; then
				optfeature "having the upstream suggested package" "${p}"
			fi
		done
	fi
}
