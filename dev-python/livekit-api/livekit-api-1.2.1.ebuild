# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="LiveKit real-time and server SDKs for Python"
HOMEPAGE="
	https://github.com/livekit/python-sdks/
	https://pypi.org/project/livekit-api/
"
SRC_URI="https://github.com/livekit/python-sdks/archive/api-v${PV}.tar.gz -> ${P}.gh.tar.gz"

MY_TOPDIR="${WORKDIR}/python-sdks-api-v${PV}"
S="${MY_TOPDIR}/livekit-api"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pyjwt-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.9.0[${PYTHON_USEDEP}]
	>=dev-python/protobuf-4[${PYTHON_USEDEP}]
	>=dev-python/types-protobuf-4[${PYTHON_USEDEP}]
	>=dev-python/livekit-protocol-1.1.27[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		${RDEPEND}
		media-video/livekit[test-server]
	)
"

EPYTEST_PLUGINS=()
EPYTEST_IGNORE=(
	# This is a different subproject this package isn't installing
	tests/rtc/
)
EPYTEST_DESELECT=(
	# fails
	tests/api/test_livekitapi.py::test_sip_busy
)
distutils_enable_tests pytest

python_test() {
	cd "${MY_TOPDIR}" || die

	# Tests expect a running LiveKit mock server
	exec 3< <(livekit-test-server || die 'could not start LiveKit test server')
	local lk_pid=$!

	# Wait until it's ready
	while IFS= read -r line <&3 || die 'could not start LiveKit test server'; do
		echo "$line"
		[[ "$line" =~ "region-3 listening" ]] && break
	done
	cat <&3 &

	nonfatal epytest
	local epytest_result=$?

	kill -INT $lk_pid
	wait $lk_pid

	(( epytest_result == 0 )) || die "pytest failed with ${EPYTHON}"
}
