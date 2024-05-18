# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

declare -A VOICES=(
	[en]="
		redistributable? (
			app-voices/rhvoice-bdl
			app-voices/rhvoice-clb
			app-voices/rhvoice-slt
		)
	"
	[ru]="redistributable? ( app-voices/rhvoice-arina )"
)

DESCRIPTION="TTS engine with extended languages support (metapackage)"
HOMEPAGE="
	https://rhvoice.org
	https://github.com/RHVoice/RHVoice
"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="redistributable"

for lang in "${!VOICES[@]}"; do
	usestr="l10n_${lang:?}"
	IUSE+=" ${usestr:?}"
	RHVOICE_REQ_USE+="${usestr:?}?,"
	RDEPEND+=" ${usestr}? ( ${VOICES[${lang:?}]} )"
done

RDEPEND+=" >=app-accessibility/rhvoice-core-${PV}[${RHVOICE_REQ_USE%,}]"
