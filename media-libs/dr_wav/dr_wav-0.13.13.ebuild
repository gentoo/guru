# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Single-header WAV audio loader and writer library"
HOMEPAGE="https://github.com/mackron/dr_libs/"
COMMIT="9eed1be421749ba68a87e5b4c3b10858f8580689"
SRC_URI="https://github.com/mackron/dr_libs/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="|| ( MIT-0 public-domain )"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( media-libs/libsndfile )"

TESTCASES=(
	dr_wav_encoding.c
	dr_wav_{decoding,test_0}.{c,cpp}
)

S="${WORKDIR}/dr_libs-${COMMIT}"

src_prepare() {
	if use test; then
		# Unbundle library with incorrect include path.
		sed -i 's,"../../../miniaudio/miniaudio.h",<miniaudio/miniaudio.h>,' \
			tests/wav/dr_wav_playback.c || die
		# Disable profiling tests as they are not relevant downstream.
		sed -i 's/doProfiling = DRWAV_TRUE/doProfiling = DRWAV_FALSE/' \
			tests/wav/dr_wav_decoding.c || die
		# Test cases dr_wav_{en,de}coding.{c,cpp} write and read a file from a
		# missing directory.
		mkdir tests/testvectors/wav/tests || die
	fi

	sed -n "11,135p" dr_wav.h > README.md || die
	sed -n "8348,8752p" dr_wav.h > CHANGELOG || die
	default

}

src_compile() {
	if use test; then
		local MY_{C,CC,CXX,BUILD,FLAGS}
		MY_CC=$(tc-getCC)
		MY_CXX=$(tc-getCXX)

		pushd tests > /dev/null || die
		for tcase in ${TESTCASES[@]}; do
			einfo "Compiling test case ${tcase}."
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
			MY_BUILD="${MY_C} wav/${tcase} -o bin/${tcase} ${MY_FLAGS} ${CPPFLAGS}"
			case ${tcase%.*} in
				dr_wav_encoding)
					MY_BUILD="${MY_BUILD} -lm ${LDFLAGS}"
					;;
				*)
					;;
			esac
			${MY_BUILD} || die "Build failed: ${MY_BUILD}"
		done
		popd || die
	fi
}

src_test() {
	local MY_RUN

	pushd tests || die
	for tcase in ${TESTCASES[@]}; do
		einfo "Running test case ${tcase}."
		MY_RUN="./bin/${tcase}"
		case ${tcase%.*} in
			dr_wav_encoding)
				MY_RUN="${MY_RUN} testvectors/wav/tests/test_encode_gentoo"
				;;
			*)
				;;
		esac
		${MY_RUN} || die "Test case ${tcase} failed."
	done
	popd || die
}

src_install() {
	einstalldocs
	doheader dr_wav.h
}
