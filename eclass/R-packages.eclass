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

# @ECLASS_VARIABLE: CRAN_SNAPSHOT_DATE
# @DEFAULT_UNSET
# @DESCRIPTION:
# The date the ebuild was updated in YYYY-MM-DD format used to fetch distfiles
# from Microsoft CRAN mirror.  This will be required in the future.

# @ECLASS_VARIABLE: CRAN_PN
# @DESCRIPTION:
# Package name to use for fetching distfiles from CRAN.
: ${CRAN_PN:=${PN//_/.}}

# @ECLASS_VARIABLE: CRAN_PV
# @DESCRIPTION:
# Package version to use for fetching distfiles from CRAN.
: ${CRAN_PV:=${PV}}

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
# @USAGE: <source> <dest>
# @DESCRIPTION:
# <dest> will contain symlinks to everything in <source>
_movelink() {
	local source=${1}
	local dest=${2}
	if [[ -e "${source}" ]]; then
		local rp_source="$(realpath ${source} || die)"
		mv "${rp_source}" "${dest}" || die
		cp -rsf "${dest}" "${rp_source}" || die
	fi
}

# @FUNCTION: R-packages_src_unpack
# @DEPRECATED: none
# @DESCRIPTION:
# Unpack R packages into the right folder.  Consider setting ${S} to appropriate
# value instead.
R-packages_src_unpack() {
	default_src_unpack

	if [[ -d "${CRAN_PN}" ]] && [[ ! -d "${P}" ]]; then
		mv "${CRAN_PN}" "${P}" || die
	fi
}

# @FUNCTION: R-packages_src_prepare
# @DEPRECATED: none
# @DESCRIPTION:
# Remove unwanted files from the sources.
R-packages_src_prepare() {
	default_src_prepare
	eqawarn "This ebuild uses R-packages_src_prepare which is no-op."
	eqawarn "You can safely remove it."
}

# @FUNCTION: R-packages_src_configure
# @DESCRIPTION:
# Set up temporary directories.
R-packages_src_configure() {
	mkdir "${T}"/R || die
}

# @FUNCTION: R-packages_src_compile
# @DESCRIPTION:
# Pass build-related environment variables to R and then build/install the
# package.
R-packages_src_compile() {
	local -a mymakeflags=(
		"${MAKEFLAGS}"
		AR="$(tc-getAR)"
		CC="$(tc-getCC)"
		CPP="$(tc-getCPP)"
		CXX="$(tc-getCXX)"
		FC="$(tc-getFC)"
		LD="$(tc-getLD)"
		NM="$(tc-getNM)"
		RANLIB="$(tc-getRANLIB)"
		CFLAGS="${CFLAGS}"
		CPPFLAGS="${CPPFLAGS}"
		CXXFLAGS="${CXXFLAGS}"
		FFLAGS="${FFLAGS}"
		FCFLAGS="${FCFLAGS}"
		LDFLAGS="${LDFLAGS}"
		MAKEOPTS="${MAKEOPTS}"
	)

	MAKEFLAGS="${mymakeflags[@]// /\\ }" \
		edo R CMD INSTALL . -d -l "${T}"/R --byte-compile
}


# @FUNCTION: R-packages_src_install
# @DESCRIPTION:
# Move files into right folders.
#
# Documentation and examples is moved to docdir, symlinked back to R
# site-library (to allow access from within R).
#
# Everything else is moved to the R site-library.
R-packages_src_install() {
	cd "${T}"/R/${CRAN_PN} || die

	local DOCDIR="/usr/share/doc/${PF}"
	local EDOCDIR="${ED}${DOCDIR}"
	mkdir -p "${EDOCDIR}" || die

	for i in {NEWS,README}.md DESCRIPTION CITATION INDEX NEWS WORDLIST News.Rd; do
		_movelink "${i}" "${EDOCDIR}/${i}"
	done

	if [[ -e html ]]; then
		_movelink html "${EDOCDIR}"/html
	fi

	if [[ -e examples ]]; then
		_movelink examples "${EDOCDIR}"/examples
		docompress -x "${DOCDIR}"/examples
	fi

	if [[ -e doc ]]; then
		pushd doc || die
		for i in *; do
			_movelink "${i}" "${EDOCDIR}/${i}"
		done
		popd || die
	fi

	rm -f LICENSE || die
	rm -rf tests test || die

	insinto /usr/$(get_libdir)/R/site-library
	doins -r "${T}"/R/${CRAN_PN}
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

EXPORT_FUNCTIONS src_unpack src_configure src_compile src_install pkg_postinst
