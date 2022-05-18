# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Nyxt - the internet on your terms."
HOMEPAGE="https://nyxt.atlas.engineer/"
if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/atlas-engineer/nyxt.git"
else
	SRC_URI="https://github.com/atlas-engineer/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD CC-BY-SA-3.0"
SLOT="0"
IUSE="X spell"

RDEPEND=""
DEPEND="${RDEPEND}
		net-libs/webkit-gtk
		net-libs/glib-networking
		gnome-base/gsettings-desktop-schemas
		sys-libs/libfixposix
		X? ( x11-misc/xclip )
		spell? ( app-text/enchant )"
BDEPEND=">=dev-lisp/sbcl-2.0.0"

src_prepare(){
	default
	ls _build/quicklisp-client
}

src_compile(){
	emake all || die emake failed
}
