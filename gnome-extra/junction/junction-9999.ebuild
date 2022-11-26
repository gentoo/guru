# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="Application/browser chooser"
HOMEPAGE="https://apps.gnome.org/app/re.sonny.Junction/"

EGIT_REPO_URI="https://github.com/sonnyp/Junction.git"

if [[ ${PV} != *9999 ]]; then
	EGIT_TAG="v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"

src_configure() {
	meson_src_configure \
		--datadir=/usr/share
}
