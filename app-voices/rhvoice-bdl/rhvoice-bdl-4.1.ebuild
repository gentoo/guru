# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RHVOICE_VOICE="bdl"
RHVOICE_VOICE_L10N="en"
inherit rhvoice-voice

MY_PN="${RHVOICE_VOICE^^}"
SRC_URI="https://rhvoice.org/download/RHVoice-voice-English-${MY_PN^^}-v${PV}.zip"

LICENSE="CC-BY-NC-ND-4.0"
