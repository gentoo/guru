# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	playerctl? ( net-libs/libsoup )
	userinfo? ( sys-apps/accountsservice )
"

DEPEND="${RDEPEND}"

IUSE="playerctl powerbar userinfo"
REQUIRED_USE="|| ( playerctl powerbar userinfo )"

src_compile() {
	if use powerbar; then
		pushd gtklock-powerbar-module || die
		emake
		popd || die
	fi

	if use playerctl; then
		pushd gtklock-playerctl-module || die
		emake
		popd || die
	fi

	if use userinfo; then
		pushd gtklock-userinfo-module || die
		emake
		popd || die
	fi
}

src_install() {
	dodir /usr/local/lib/gtklock
	if use powerbar; then
		pushd gtklock-powerbar-module || die
		insinto /usr/local/lib/gtklock && doins powerbar-module.so
		popd || die
	fi

	if use playerctl; then
		pushd gtklock-playerctl-module || die
		insinto /usr/local/lib/gtklock && doins playerctl-module.so
		popd || die
	fi

	if use userinfo; then
		pushd gtklock-userinfo-module || die
		insinto /usr/local/lib/gtklock && doins userinfo-module.so
		popd || die
	fi
}

