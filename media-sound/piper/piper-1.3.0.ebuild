# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

ESPEAK_NG_COMMIT="212928b394a96e8fd2096616bfd54e17845c48f6"

DESCRIPTION="Fast and local neural text-to-speech engine"
HOMEPAGE="https://github.com/OHF-Voice/piper1-gpl"
SRC_URI="
	https://github.com/OHF-Voice/piper1-gpl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/espeak-ng/espeak-ng/archive/${ESPEAK_NG_COMMIT}.tar.gz -> espeak-ng-1.52.0_p20250322.tar.gz
"

S="${WORKDIR}/piper1-gpl-${PV}"
ESPEAK_NG="${WORKDIR}/espeak-ng-${ESPEAK_NG_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="server"

RDEPEND="
	media-libs/sonic
	sci-libs/onnxruntime[python,${PYTHON_USEDEP}]

	server? ( dev-python/flask[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/scikit-build[${PYTHON_USEDEP}]
"

# Both of the packages below install `/usr/bin/piper`, and
# `app-misc/piper` also installs a Python module with the same name
DEPEND+="
	!!app-misc/piper
	!!net-proxy/piper
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# See https://github.com/espeak-ng/espeak-ng/issues/2048
	sed 's/160/1024/' -i "${ESPEAK_NG}/src/libespeak-ng/speech.h" || die

	sed \
	-e "s|GIT_REPOSITORY.*|SOURCE_DIR ${ESPEAK_NG}|" \
	-e 's|GIT_TAG.*|DOWNLOAD_COMMAND ""|' \
	-i CMakeLists.txt || die
}

src_install() {
	distutils-r1_src_install

	dodoc "${ED}/usr/COPYING"
	rm "$_"
}
