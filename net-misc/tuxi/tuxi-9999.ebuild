# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Tuxi is a cli assistant. Get answers of your questions instantly."
HOMEPAGE="https://github.com/Bugswriter/tuxi"
EGIT_REPO_URI="https://github.com/Bugswriter/tuxi.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND="app-misc/pup
app-text/recode
app-misc/jq"
RDEPEND="${DEPEND}"

src_install() {
	dobin "tuxi"
}
