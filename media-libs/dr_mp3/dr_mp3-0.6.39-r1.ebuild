# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

COMMIT="da35f9d6c7374a95353fd1df1d394d44ab66cf01"

DESCRIPTION="Single-header MP3 audio decoder library"
HOMEPAGE="https://github.com/mackron/dr_libs/"
SRC_URI="https://github.com/mackron/dr_libs/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/dr_libs-${COMMIT}"

LICENSE="|| ( MIT-0 public-domain )"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

# Unfortunately, the only other test is interactive.
TESTCASES=(
	dr_mp3_test_0.c
)

src_prepare() {
	sed 's/Introducation/Introduction/' -i dr_mp3.h || die
	awk '/Introduction/,/\*\//' dr_mp3.h | sed '$d' > README.md
	assert
	awk '/REVISION HISTORY/,/\*\//' dr_mp3.h | sed '$d' > CHANGELOG
	assert
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
