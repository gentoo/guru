# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	phosh-osk-stub:phosh-base/phosh-osk-stub
	squeekboard:phosh-base/squeekboard
)

inherit app-alternatives

DESCRIPTION="sm.puri.OSK0.desktop symlinks"
KEYWORDS="~amd64"

src_install() {
	local target="/usr/share/applications/sm.puri.OSK0.desktop"

	case $(get_alternative) in
		phosh-osk-stub)
			dosym sm.puri.Phosh.OskStub.desktop "${target:?}";;
		squeekboard)
			dosym sm.puri.Squeekboard.desktop "${target:?}";;
	esac
}
