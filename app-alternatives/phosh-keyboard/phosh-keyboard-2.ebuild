# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	"stevia:phosh-base/phosh-osk-stevia"
)

inherit app-alternatives

DESCRIPTION="sm.puri.OSK0.desktop symlinks"
KEYWORDS="~amd64"

src_install() {
	local target="/usr/share/applications/sm.puri.OSK0.desktop"

	case $(get_alternative) in
		phosh-osk-stub)
			dosym mobi.phosh.Stevia.desktop "${target:?}";;
	esac
}
