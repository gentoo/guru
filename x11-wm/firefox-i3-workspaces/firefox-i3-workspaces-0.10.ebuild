# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Restore Firefox windows to correct i3 workspaces, helper web extension is needed"
HOMEPAGE="https://github.com/yurikhan/firefox-i3-workspaces"
SRC_URI="https://github.com/yurikhan/$PN/archive/refs/tags/$PV.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"

RDEPEND="
	x11-wm/i3
	dev-python/i3ipc
"

PATCHES=(
	"$FILESDIR/path-adapt.patch"
)

src_install() {
	path_py="$ED/usr/lib/"
	mkdir -p $path_py || die
	cp host/i3_workspaces.py $path_py || die
	# Not dobin because this is not for the user CLI - only Firefox should call this

	path_json=/usr/lib64/mozilla/native-messaging-hosts/
	mkdir -p "$ED/$path_json" || die
	cp host/i3_workspaces.json "$ED$path_json" || die
}

pkg_postinst() {
	einfo "Install browser extension from https://addons.mozilla.org/en-US/firefox/addon/i3-workspaces/"
}
