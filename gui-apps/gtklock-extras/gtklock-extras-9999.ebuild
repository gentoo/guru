# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3
DESCRIPTION="Gtklock modules"
HOMEPAGE="https://github.com/jovanlanik/gtklock"
EGIT_REPO_URI=https://github.com/MrDuartePT/gtklock-modules-gentoo

LICENSE="GPL-3"
SLOT="0"

RDEPEND="gui-apps/gtklock"

BDEPEND="x11-libs/gtk+
	virtual/pkgconfig
	playerctl? ( dev-go/act )
	playerctl? ( net-libs/libsoup:2.4 )
	playerctl? ( media-sound/playerctl )
	userinfo? ( sys-apps/accountsservice )
"

DEPEND="${RDEPEND}"

IUSE="playerctl powerbar userinfo"
REQUIRED_USE="|| ( playerctl powerbar userinfo )"

src_prepare() {
	if use powerbar; then
		cd "${S}/gtklock-powerbar-module" || die
		eapply "${S}/gtklock-powerbar-module.patch"
		cd "${S}" || die
	fi

	if use playerctl; then
		cd "${S}/gtklock-playerctl-module" || die
		eapply "${S}/gtklock-playerctl-module.patch"
		cd "${S}" || die
	fi

	if use userinfo; then
		cd "${S}/gtklock-userinfo-module" || die
		eapply "${S}/gtklock-userinfo-module.patch"
		cd "${S}" || die
	fi
	eapply_user
}

src_install() {
	dodir /usr/local/lib/gtklock
	if use powerbar; then
		pushd gtklock-powerbar-module || die
		emake
		emake DESTDIR="${D}" install
		popd || die
	fi

	if use playerctl; then
		pushd gtklock-playerctl-module || die
		emake
		emake DESTDIR="${D}" install
		popd || die
	fi

	if use userinfo; then
		pushd gtklock-userinfo-module || die
		emake
		emake DESTDIR="${D}" install
		popd || die
	fi
}
