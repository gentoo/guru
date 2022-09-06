# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/hare"
	SLOT="0"
else
	EGIT_COMMIT="296925c91d79362d6b8ac94e0336a38e9af0f1c9"
	SRC_URI="https://git.sr.ht/~sircmpwn/hare/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
	SLOT="0/${PV}"

	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="The Hare systems programming language"
HOMEPAGE="https://harelang.org/"
LICENSE="MPL-2.0 GPL-3"

DEPEND="
	sys-devel/qbe
	>=dev-lang/harec-0_pre20220702
"
BDEPEND="
	app-text/scdoc
"
RDEPEND="${DEPEND}"

# hare and harec are built by hare
QA_FLAGS_IGNORED="usr/bin/harec?"

src_configure() {
	local target_arch
	case ${ARCH} in
		amd64 ) target_arch=x86_64 ;;
		arm64 ) target_arch=aarch64 ;;
		riscv ) target_arch=riscv64 ;;
		* ) die "unsupported architecture: ${ARCH}" ;;
	esac

	cp config.example.mk config.mk || die
	sed -i \
		-e 's;=aarch64-;=;' \
		-e 's;=riscv64-;=;' \
		-e "s;^ARCH =.*;ARCH=${target_arch};" \
		-e 's;^PREFIX=.*;PREFIX=/usr;' \
		-e 's;^AS =;AS ?=;' \
		-e 's;^LD =;LD ?=;' \
		-e 's;^AR =;AR ?=;' \
		config.mk || die

	sed -i 's; $(DESTDIR)$(LOCALSRCDIR);;' Makefile || die
}
