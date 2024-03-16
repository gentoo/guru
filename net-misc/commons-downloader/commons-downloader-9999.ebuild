# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker git-r3

DESCRIPTION="A shell script to bulk download files from Wikimedia Commons, by category"
HOMEPAGE="https://git.sr.ht/~nytpu/commons-downloader"
EGIT_REPO_URI="https://git.sr.ht/~nytpu/commons-downloader"

LICENSE="CC0-1.0"
SLOT=0
QA_PREBUILT="*"

RDEPEND="
	net-misc/curl
	net-misc/wget
	app-misc/jq
"

src_install() {
	dobin ${PN}
}

pkg_postinst() {
	einfo "See documentation at https://git.sr.ht/~nytpu/commons-downloader"
	einfo "Example how to download a category to the current folder: commons-downloader -c 'My category name'"
}
