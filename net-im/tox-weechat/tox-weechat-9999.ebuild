# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 patches

DESCRIPTION="Tox plugin for WeeChat"
HOMEPAGE="https://github.com/haavard/tox-weechat"
EGIT_REPO_URI="https://github.com/haavard/tox-weechat"

LICENSE="GPL-3"
SLOT="0"

src_configure() {
	local mycmakeargs=(
		-DPLUGIN_PATH="/usr/$(get_libdir)/weechat/plugins"
	)
	cmake_src_configure
}
