# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="WAV audio loader and writer"
HOMEPAGE="https://github.com/mackron/dr_libs/"
COMMIT="d35a3bc5efd02455d98cbe12b94647136f09b42d"
SRC_URI="https://raw.githubusercontent.com/mackron/dr_libs/${COMMIT}/dr_wav.h -> ${P}.gh.h
	https://raw.githubusercontent.com/mackron/dr_libs/${COMMIT}/README.md -> ${P}-README.md
	test? ( https://github.com/mackron/dr_libs/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz )"

LICENSE="|| ( MIT-0 public-domain )"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( media-libs/libsndfile )"

S="${DISTDIR}"

src_prepare() {
	if use test; then
		pushd "${WORKDIR}/dr_libs-${COMMIT}" > /dev/null || die
		# Remove some unused parts of the source tree that could contribute different
		# (but acceptable) license terms if they were used—just to prove that we do not
		# use them.
		rm -rv old

		# Unbundle library with incorrect include path.
		sed -i 's,"../../../miniaudio/miniaudio.h",<miniaudio/miniaudio.h>,' \
			tests/wav/dr_wav_playback.c || die
		# Profiling tests aren't implemented.
		sed -i 's/doProfiling = DRWAV_TRUE/doProfiling = DRWAV_FALSE/' \
			tests/wav/dr_wav_decoding.c || die
		popd || die
	fi
	default
}

src_test() {
	local MY_{C,CC,CXX,BUILD,FLAGS,RUN} TESTCASES
	TESTCASES=(
		dr_wav_encoding.c
		dr_wav_{decoding,test_0}.{c,cpp}
	)
	MY_CC=$(tc-getCC)
	MY_CXX=$(tc-getCXX)

	pushd "${WORKDIR}/dr_libs-${COMMIT}/tests" > /dev/null || die
	for tcase in ${TESTCASES[@]}; do
		einfo "Compiling and running test case ${tcase}."
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
		MY_RUN="./bin/${tcase}"
		case ${tcase%.*} in
			dr_wav_encoding)
				MY_BUILD="${MY_BUILD} -lm"
				MY_RUN="${MY_RUN} testvectors/wav/tests/test_encode_gentoo"
				mkdir testvectors/wav/tests || die
				;;
			*)
				;;
		esac
		echo "${MY_BUILD}" || die
		${MY_BUILD} || die "Build failed: ${MY_BUILD}"
		echo "${MY_RUN}" || die
		${MY_RUN} || die "Test case ${MY_RUN} failed."
	done
	popd || die
}

src_install() {
	newheader ${P}.gh.h ${PN}.h
	newdoc ${P}-README.md README.md
}
