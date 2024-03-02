# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="Single-header FLAC audio decoder library"
HOMEPAGE="https://github.com/mackron/dr_libs/"
declare -A COMMITS=(
	[dr_flac]="39ce69188eab79a913aa23423eef9da5f3dcd142"
	[testbench]="aa7b0c6cf32994c106ae517a08134c28a96ff5b2"
)
SRC_URI="https://github.com/mackron/dr_libs/archive/${COMMITS[dr_flac]}.tar.gz -> ${P}.gh.tar.gz
test? ( https://github.com/ietf-wg-cellar/flac-test-files/archive/${COMMITS[testbench]}.tar.gz
		-> ${P}-testbench.gh.tar.gz )"

LICENSE="|| ( MIT-0 public-domain )"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( media-libs/flac )"

TESTCASES=(
	dr_flac_seeking.c
	dr_flac_{decoding,test_0}.{c,cpp}
)

S="${WORKDIR}/dr_libs-${COMMITS[dr_flac]}"

src_prepare() {
	if use test; then
		# Sanitize testbench and move to expected location
		find "${WORKDIR}"/flac-test-files-${COMMITS[testbench]}/subset -type f \
			 \! -name "*.flac" -delete || die
		mv -T "${WORKDIR}"/flac-test-files-${COMMITS[testbench]}/subset \
		   tests/testvectors/flac/testbench || die

		# Disable profiling tests as they are not relevant downstream.
		for tcase in ${TESTCASES[@]}; do
			sed -i "s/doProfiling = DRFLAC_TRUE/doProfiling = DRFLAC_FALSE/" \
				tests/flac/$tcase || die "sed failed on tests/flac/$tcase"
		done

	fi

	awk '/Introduction/,/\*\//' dr_flac.h | sed '$d' > README.md
	assert
	awk '/REVISION HISTORY/,/\*\//' dr_flac.h | sed '$d' > CHANGELOG
	assert
	default
}

src_compile() {
	if use test; then
		local MY_{C,CC,CXX,BUILD,FLAGS}
		MY_CC=$(tc-getCC)
		MY_CXX=$(tc-getCXX)

		pushd tests > /dev/null || die
		for tcase in ${TESTCASES[@]}; do
			case ${tcase} in
				*.cpp)
					MY_C=${MY_CXX}
					MY_FLAGS=${CXXFLAGS}
					;;
				*.c)
					MY_C=${MY_CC}
					MY_FLAGS=${CFLAGS}
					;;
				*)
					die "Unknown test case ${tcase}"
					;;
			esac
			MY_BUILD="${MY_C} flac/${tcase} -o bin/${tcase} ${MY_FLAGS} ${CPPFLAGS}"
			case ${tcase%.*} in
				dr_flac_seeking)
				;&
				dr_flac_decoding)
					MY_BUILD="${MY_BUILD} -lFLAC ${LDFLAGS}"
					;;
				*)
					;;
			esac
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
	doheader dr_flac.h
}
