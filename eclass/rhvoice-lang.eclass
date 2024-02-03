# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rhvoice-lang.eclass
# @MAINTAINER:
# Anna <cyber+gentoo@sysrq.in>
# @AUTHOR:
# Anna <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @BLURB: eclass for packaging RHVoice languages
# @DESCRIPTION:
# An eclass streamlining the construction of ebuilds for the officially
# supported RHVoice languages.
#
# Look at "src/scripts" files to identify language's license.
# @EXAMPLE:
#
# Most ebuilds will look like this:
#
# @CODE
#
# EAPI=8
#
# RHVOICE_LANG="Russian"
# inherit rhvoice-lang
#
# LICENSE="LGPL-2.1+"
#
# @CODE

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_RHVOICE_LANG_ECLASS} ]]; then
_RHVOICE_LANG_ECLASS=1

# @ECLASS_VARIABLE: RHVOICE_LANG
# @PRE_INHERIT
# @REQUIRED
# @DESCRIPTION:
# Full language name (see "data/languages" in RHVoice source code).

if [[ ! ${RHVOICE_LANG} ]]; then
	die "RHVOICE_LANG must be set before inherit"
fi

# @ECLASS_VARIABLE: RHVOICE_LANG_REPO
# @PRE_INHERIT
# @DESCRIPTION:
# Repository name under the RHVoice GitHub organization.
: "${RHVOICE_LANG_REPO:=${RHVOICE_LANG:?}}"

# @ECLASS_VARIABLE: RHVOICE_LANG_TAG
# @PRE_INHERIT
# @DESCRIPTION:
# Tag name for generating SRC_URI.
: "${RHVOICE_LANG_TAG:=${PV}}"

# @ECLASS_VARIABLE: RHVOICE_LANG_DISTFILE
# @PRE_INHERIT
# @DESCRIPTION:
# Distfile name for generating SRC_URI, should be a ZIP archive.
: "${RHVOICE_LANG_DISTFILE:=RHVoice-language-${RHVOICE_LANG}-v${PV}.zip}"

DESCRIPTION="${RHVOICE_LANG:?} language support for RHVoice"
HOMEPAGE="https://github.com/RHVoice/${RHVOICE_LANG_REPO:?}"
SRC_URI="https://github.com/RHVoice/${RHVOICE_LANG_REPO}/releases/download/${RHVOICE_LANG_TAG}/${RHVOICE_LANG_DISTFILE} -> ${P}.zip"
S="${WORKDIR}"

KEYWORDS="~amd64 ~x86"
SLOT="0"

BDEPEND="app-arch/unzip"

# @FUNCTION: rhvoice-lang_src_prepare
# @DESCRIPTION:
# Remove stray files such as licenses.
rhvoice-lang_src_prepare() {
	debug-print-function ${FUNCNAME} "${@}"

	default_src_prepare
	find . -name "COPYING*" -o -name "LICENSE*" -delete || \
			die "removing licenses failed"
}

# @FUNCTION: rhvoice-lang_src_install
# @DESCRIPTION:
# Install the language.
rhvoice-lang_src_install() {
	debug-print-function ${FUNCNAME} "${@}"

	shopt -s nullglob
	local docs=( README* )
	shopt -u nullglob

	for doc in "${docs[@]}"; do
		dodoc "${doc}"
		rm "${doc}" || die "removing ${doc}" failed
	done

	insinto /usr/share/RHVoice/languages/${RHVOICE_LANG:?}
	doins -r .
}

fi

EXPORT_FUNCTIONS src_prepare src_install
