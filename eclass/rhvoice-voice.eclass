# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rhvoice-voice.eclass
# @MAINTAINER:
# Anna <cyber+gentoo@sysrq.in>
# @AUTHOR:
# Anna <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @BLURB: eclass for packaging RHVoice voices
# @DESCRIPTION:
# An eclass streamlining the construction of ebuilds for the officially
# supported RHVoice voices.
#
# Look at "copyright" files to identify voice's license.
# @EXAMPLE:
#
# Most ebuilds will look like this:
#
# @CODE
#
# EAPI=8
#
# RHVOICE_VOICE="arina"
# RHVOICE_VOICE_REPO="arina-rus"
# RHVOICE_VOICE_L10N="ru"
# inherit rhvoice-voice
#
# LICENSE="CC-BY-NC-ND-4.0"
#
# @CODE

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_RHVOICE_VOICE_ECLASS} ]]; then
_RHVOICE_VOICE_ECLASS=1

# @ECLASS_VARIABLE: RHVOICE_VOICE
# @PRE_INHERIT
# @REQUIRED
# @DESCRIPTION:
# Voice name (see "data/voices" in RHVoice source code).

# @ECLASS_VARIABLE: RHVOICE_VOICE_L10N
# @PRE_INHERIT
# @REQUIRED
# @DESCRIPTION:
# Language name in L10N USE_EXPAND syntax.

if [[ ! ${RHVOICE_VOICE} ]]; then
	die "RHVOICE_VOICE must be set before inherit"
fi

if [[ ! ${RHVOICE_VOICE_L10N} ]]; then
	die "RHVOICE_VOICE_L10N must be set before inherit"
fi

# @ECLASS_VARIABLE: RHVOICE_VOICE_REPO
# @PRE_INHERIT
# @DESCRIPTION:
# Repository name under the RHVoice GitHub organization.
: "${RHVOICE_VOICE_REPO:=${RHVOICE_VOICE:?}}"

# @ECLASS_VARIABLE: RHVOICE_VOICE_TAG
# @PRE_INHERIT
# @DESCRIPTION:
# Tag name for generating SRC_URI.
: "${RHVOICE_VOICE_TAG:=${PV}}"

# @ECLASS_VARIABLE: RHVOICE_VOICE_DISTFILE
# @PRE_INHERIT
# @DESCRIPTION:
# Distfile name for generating SRC_URI, should be a ZIP archive.
: "${RHVOICE_VOICE_DISTFILE:=data.zip}"

DESCRIPTION="RHVoice voice: ${RHVOICE_VOICE:?} (${RHVOICE_VOICE_L10N:?})"
HOMEPAGE="https://github.com/RHVoice/${RHVOICE_VOICE_REPO:?}"
SRC_URI="https://github.com/RHVoice/${RHVOICE_VOICE_REPO}/releases/download/${RHVOICE_VOICE_TAG}/${RHVOICE_VOICE_DISTFILE} -> ${P}.zip"
S="${WORKDIR}"

KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="app-accessibility/rhvoice-core[l10n_${RHVOICE_VOICE_L10N}]"
BDEPEND="app-arch/unzip"

# @FUNCTION: rhvoice-voice_src_install
# @DESCRIPTION:
# Install the voice.
rhvoice-voice_src_install() {
	debug-print-function ${FUNCNAME} "${@}"

	insinto /usr/share/RHVoice/voices/${RHVOICE_VOICE:?}
	doins -r .
}

fi

EXPORT_FUNCTIONS src_install
