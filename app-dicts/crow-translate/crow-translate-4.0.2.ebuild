# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Application that allows you to translate and speak text"
HOMEPAGE="https://invent.kde.org/office/crow-translate"
SRC_URI="https://download.kde.org/stable/${PN}/${PV}/${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3+ CC-BY-SA-4.0 CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="piper-tts wayland"

DEPEND="
	app-text/tesseract
	dev-libs/qhotkey
	dev-qt/qtbase:6[concurrent,dbus,gui,network,widgets]
	dev-qt/qtmultimedia:6
	dev-qt/qtscxml:6
	dev-qt/qtspeech:6
	x11-libs/libxcb
	wayland? ( kde-plasma/kwayland:6 )
	piper-tts? ( sci-libs/onnxruntime )
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=kde-frameworks/extra-cmake-modules-6.4.0
	dev-qt/qttools:6[linguist]
"

RESTRICT="mirror"

PATCHES=(
	"${FILESDIR}/${P}-system-qhotkey.patch"
)

src_prepare() {
	sed -i 's/\r$//' CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DWITH_KWAYLAND=$(usex wayland)
		-DWITH_PIPER_TTS=$(usex piper-tts)
	)
	cmake_src_configure
}
