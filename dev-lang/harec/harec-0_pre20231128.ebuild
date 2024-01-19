# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/harec"
	S="${WORKDIR}/${P}/build"
else
	EGIT_COMMIT="ec3193e3870436180b0f3df82b769adc57a1c099"
	MY_P="${PN}-${EGIT_COMMIT}"
	SRC_URI="https://git.sr.ht/~sircmpwn/harec/archive/${EGIT_COMMIT}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}/${MY_P}/build"

	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="The Hare compiler"
HOMEPAGE="https://harelang.org/"
LICENSE="GPL-3"
SLOT="0"

DEPEND=">=sys-devel/qbe-1.1-r1"
RDEPEND="${DEPEND}"

src_unpack() {
	default

	[[ "${PV}" = "9999" ]] && git-r3_src_unpack

	mkdir "${S}" || die
}

src_prepare() {
	default

	sed -i 's; -Werror ; ;' ../config.sh || die
}

src_configure() {
	../configure --prefix="/usr" --libdir="/usr/$(get_libdir)" || die
}
