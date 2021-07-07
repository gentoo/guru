# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="C++17 header-only implementation of the XDG Base Directory Specification"
HOMEPAGE="https://sr.ht/~danyspin97/xdgpp"
SRC_URI="
	https://git.sr.ht/~danyspin97/xdgpp/commit/d41f2b8189619f27aca1b6f1bf7b1ef4af8bb482.patch -> ${PN}-01.patch
	https://git.sr.ht/~danyspin97/xdgpp/commit/3ca427d179412892a111b879a4253b146ba94b0c.patch -> ${PN}-02.patch
	https://git.sr.ht/~danyspin97/xdgpp/commit/0067fd493a92eb83dba701f010673509e0739f90.patch -> ${PN}-03.patch
	https://git.sr.ht/~danyspin97/xdgpp/commit/64af46f747c0d341f02bc5940b51676a58edf805.patch -> ${PN}-04.patch
	https://git.sr.ht/~danyspin97/xdgpp/commit/3fc23f3bdafb3c6257550899c0ee961a3dde4ead.patch -> ${PN}-05.patch
	https://git.sr.ht/~danyspin97/xdgpp/commit/fe313459e66daf6a07eeaeb04f4af8026b00d17a.patch -> ${PN}-06.patch
	https://git.sr.ht/~danyspin97/xdgpp/commit/8876042883b2e78382c0d4ba945a6d254f860728.patch -> ${PN}-07.patch
	https://git.sr.ht/~danyspin97/xdgpp/commit/04e34105c5e227ee061ee592cf4d75ef8a33f716.patch -> ${PN}-08.patch
	https://git.sr.ht/~danyspin97/xdgpp/commit/f01f810714443d0f10c333d4d1d9c0383be41375.patch -> ${PN}-09.patch
"
S="${WORKDIR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-cpp/catch:0"
DEPEND="${RDEPEND}"

RESTRICT="!test? ( test )"
PATCHES=(
	"${DISTDIR}/${PN}-01.patch"
	"${DISTDIR}/${PN}-02.patch"
	"${DISTDIR}/${PN}-03.patch"
	"${DISTDIR}/${PN}-04.patch"
	"${DISTDIR}/${PN}-05.patch"
	"${DISTDIR}/${PN}-06.patch"
	"${DISTDIR}/${PN}-07.patch"
	"${DISTDIR}/${PN}-08.patch"
	"${DISTDIR}/${PN}-09.patch"
)

src_install() {
	doheader xdg.hpp
	dodoc README.md
}

src_test() {
	emake test
}
