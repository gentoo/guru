# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="minimal strictly POSIX compliant shell"
HOMEPAGE="https://git.sr.ht/~emersion/mrsh"
EGIT_REPO_URI="https://git.sr.ht/~emersion/mrsh"
LICENSE="MIT"
SLOT="0"

IUSE="+readline libedit"
REQUIRED_USE="?? ( libedit readline )"

DEPEND="
	libedit? ( dev-libs/libedit )
	readline? ( sys-libs/readline:= )
"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_configure() {
	local emesonargs=(
		-Dwerror=false
		-Dauto_features=disabled
	)

	if use readline || use libedit; then
		emesonargs+=(
			-Dreadline=enabled
			-Dreadline-provider=$(usev readline || usev libedit)
		)
	fi

	meson_src_configure
}
