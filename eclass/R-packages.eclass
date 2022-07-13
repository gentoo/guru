# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: R-packages.eclass
# @AUTHOR:
# Alessandro Barbieri <lssndrbarbieri@gmail.com>
# André Erdmann <dywi@mailerd.de>
# Benda Xu <heroxbd@gentoo.org>
# Denis Dupeyron <calchan@gentoo.org>
# Robert Greener <me@r0bert.dev>
# @BLURB: eclass to build R packages
# @MAINTAINER:
# Alessandro Barbieri <lssndrbarbieri@gmail.com>
# @SUPPORTED_EAPIS: 7 8

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [ ! ${_R_PACKAGES_ECLASS} ]; then

inherit edo eutils optfeature toolchain-funcs

# @ECLASS_VARIABLE: SUGGESTED_PACKAGES
# @DEPRECATED: none
# @DEFAULT_UNSET
# @DESCRIPTION:
# String variable containing the list of upstream suggested packages.  Consider
# using optfeature directly instead for more concise descriptions.

# @ECLASS_VARIABLE: CRAN_PN
# @DESCRIPTION:
# Package name to use for fetching distfiles from CRAN.
: ${CRAN_PN:=${PN//_/.}}

# @ECLASS_VARIABLE: CRAN_PV
# @DESCRIPTION:
# Package version to use for fetching distfiles from CRAN.
: ${CRAN_PV:=${PV}}

# Set CRAN_SNAPSHOT_DATE to the date the ebuild was updated in the ebuild

if [[ ${CRAN_SNAPSHOT_DATE} ]]; then
	SRC_URI="https://cran.microsoft.com/snapshot/${CRAN_SNAPSHOT_DATE}"
else
	SRC_URI="mirror://cran"
fi
SRC_URI+="/src/contrib/${CRAN_PN}_${CRAN_PV}.tar.gz"

HOMEPAGE="https://cran.r-project.org/package=${CRAN_PN}"

SLOT="0"

DEPEND="dev-lang/R"
RDEPEND="${DEPEND}"

# @FUNCTION: _movelink
# @INTERNAL
# @USAGE: [<source> <dest>]
# @DESCRIPTION:
# <dest> will contain symlinks to everything in <source>
_movelink() {
	if [[ -e "${1}" ]]; then
		local rp1="$(realpath ${1} || die)"
		mv "${rp1}" "${2}" || die
		cp -rsf "${2}" "${rp1}" || die
	fi
}

# @FUNCTION: R-packages_src_unpack
# @DESCRIPTION:
# function to unpack R packages into the right folder
R-packages_src_unpack() {
	unpack ${A}
	if [[ -d "${CRAN_PN}" ]] && [[ ! -d "${P}" ]]; then
		mv "${CRAN_PN}" "${P}" || die
	fi
}

# @FUNCTION: R-packages_src_prepare
# @DESCRIPTION:
# function to remove unwanted files from the sources
R-packages_src_prepare() {
	rm -f LICENSE || die
	default
	mkdir -p "${T}/R" || die
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
	edo R CMD INSTALL . -d -l "${T}/R" "--byte-compile"
}


# @FUNCTION: R-packages_src_install
# @DESCRIPTION:
# function to move the files in the right folders
# documentation and examples to docsdir, symlinked back to R site-library (to allow access from within R)
# everything else to R site-library
R-packages_src_install() {
	pushd "${T}/R/${CRAN_PN}" || die

	local DOCS_DIR="/usr/share/doc/${PF}"

	mkdir -p "${ED}/${DOCS_DIR}" || die

	for i in NEWS.md README.md DESCRIPTION examples CITATION INDEX NEWS WORDLIST News.Rd ; do
		_movelink "${i}" "${ED}${DOCS_DIR}/${i}" || die
		docompress -x "${DOCS_DIR}/${i}"
	done

	if [[ -e html ]]; then
		_movelink html "${ED}${DOCS_DIR}/html" || die
		docompress -x "${DOCS_DIR}/html"
	fi
	if [[ -e doc ]]; then
		pushd doc || die
		for i in * ; do
			_movelink "${i}" "${ED}${DOCS_DIR}/${i}" || die
			docompress -x "${DOCS_DIR}/${i}"
		done
		popd || die
	fi
	if [[ -e doc/html ]]; then
		docompress -x "${DOCS_DIR}/html"
	fi
	docompress -x "${DOCS_DIR}"

	rm -rf tests test || die

	insinto "/usr/$(get_libdir)/R/site-library"
	doins -r "${T}/R/${CRAN_PN}"
}

# @FUNCTION: R-packages_pkg_postinst
# @DEPRECATED: optfeature
# @DESCRIPTION:
# Prompt to install the upstream suggested packages (if they exist).  Consider
# calling "optfeature" directly instead for concise descriptions.
R-packages_pkg_postinst() {
	for p in ${SUGGESTED_PACKAGES}; do
		optfeature "having the upstream suggested package" "${p}"
	done
}

_R_PACKAGES_ECLASS=1
fi

EXPORT_FUNCTIONS src_unpack src_prepare src_configure src_compile src_install pkg_postinst
