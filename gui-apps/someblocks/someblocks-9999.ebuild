# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig git-r3

DESCRIPTION="Modular status bar for somebar written in c."
HOMEPAGE="https://git.sr.ht/~raphi/someblocks"
EGIT_REPO_URI="https://git.sr.ht/~raphi/someblocks"

LICENSE="ISC"
SLOT="0"

RDEPEND="${DEPEND}"

src_prepare() {
	default

	restore_config blocks.h
}

src_install() {
	emake PREFIX="${ED}/usr" install

	einstalldocs

	save_config blocks.h
}
