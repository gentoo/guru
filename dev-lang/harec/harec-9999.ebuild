# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/harec"
else
	EGIT_COMMIT="770566a51aa972c320b545d2292626057aabe831"
	MY_P="${PN}-${EGIT_COMMIT}"
	SRC_URI="https://git.sr.ht/~sircmpwn/harec/archive/${EGIT_COMMIT}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="The Hare compiler"
HOMEPAGE="https://harelang.org/"
LICENSE="GPL-3"
SLOT="0"

# sys-devel/qbe-1.1-r1 won't build a proper binary.
DEPEND="~sys-devel/qbe-9999"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	cp configs/linux.mk config.mk || die
	sed -i 's/-Werror//' config.mk || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
