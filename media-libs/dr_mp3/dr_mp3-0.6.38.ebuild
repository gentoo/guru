# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="Single-header MP3 audio decoder library"
HOMEPAGE="https://github.com/mackron/dr_libs/"
COMMIT="01d23df76776faccee3bc456f685900dcc273b4c"
SRC_URI="https://github.com/mackron/dr_libs/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="|| ( MIT-0 public-domain )"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

S="${WORKDIR}/dr_libs-${COMMIT}"

# Unfortunately, the only other test is interactive.
TESTCASES=(
	dr_mp3_test_0.c
)

src_prepare() {
	sed -n "36,83p" dr_mp3.h > README.md || die
	sed -n "4496,4776p" dr_mp3.h > CHANGELOG || die
	default
}

src_compile() {
	if use test; then
		local MY_{CC,BUILD}
		MY_CC=$(tc-getCC)

		pushd tests > /dev/null || die
		for tcase in ${TESTCASES[@]}; do
			MY_BUILD="${MY_CC} mp3/${tcase} -o bin/${tcase} ${CFLAGS} ${CPPFLAGS}"
			edo ${MY_BUILD}
		done
		popd || die
	fi
}

src_test() {
	pushd tests > /dev/null || die
	for tcase in ${TESTCASES[@]}; do
		edo bin/${tcase}
	done
	popd || die
}

src_install() {
	einstalldocs
	doheader dr_mp3.h
}
