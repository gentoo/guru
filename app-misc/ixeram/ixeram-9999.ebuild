EAPI=8

inherit cmake git-r3

DESCRIPTION="CLI tool for RAM information and management"
HOMEPAGE="https://github.com/mystergaif/IxeRam"
EGIT_REPO_URI="https://github.com/mystergaif/IxeRam.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-libs/keystone
	dev-libs/capstone
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmake"

src_install() {
	cmake_src_install
	dobin "${BUILD_DIR}/memdebug"
	dosym memdebug /usr/bin/ixeram
	dolib.so "${BUILD_DIR}/libspeedhack.so"
}
