# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature wrapper

DESCRIPTION="Feature rich Discord TUI client"
HOMEPAGE="https://github.com/sparklost/endcord"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sparklost/endcord.git"
else
	SRC_URI="https://github.com/sparklost/endcord/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT=0

BDEPEND="
	>=dev-python/cython-3.2.4[${PYTHON_USEDEP}]
"
RDEPEND="
	>=dev-python/emoji-2.15.0[${PYTHON_USEDEP}]
	>=dev-python/filetype-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-2.4.3[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.11.7[${PYTHON_USEDEP}]
	>=dev-python/protobuf-7.34.0[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.23.0[${PYTHON_USEDEP}]
	>=dev-python/pynacl-1.6.2[${PYTHON_USEDEP}]
	>=dev-python/pysocks-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/python-socks-2.8.1[${PYTHON_USEDEP}]
	>=dev-python/qrcode-8.2[${PYTHON_USEDEP}]
	>=dev-python/soundcard-0.4.5[${PYTHON_USEDEP}]
	>=dev-python/soundfile-0.13.1[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2.6.3[${PYTHON_USEDEP}]
	>=dev-python/websocket-client-1.9.0[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${PN}-1.3.0-flags.patch" )

DOCS=( README.md docs/ )

python_install() {
	distutils-r1_python_install

	python_domodule ${PN}

	exeinto /usr/libexec/${PN}
	doexe main.py

	make_wrapper ${PN} \
		"${EPYTHON} ${EPREFIX}/usr/libexec/${PN}/main.py"
}

pkg_postinst() {
	optfeature "clipboard support on X11" x11-misc/xclip
	optfeature "clipboard support on Wayland" gui-apps/wl-clipboard

	optfeature "file dialog when uploading" \
		app-misc/yazi \
		gnome-extra/zenity \
		kde-apps/kdialog

	optfeature "spellchecking (requires aspell dictionary such as aspell-en)" \
		app-text/aspell

	optfeature "YouTube support" net-misc/yt-dlp
	optfeature "play YouTube videos in native player (non-ASCII support)" media-video/mpv

	optfeature "store token in system keyring (requires gnome-keyring running under dbus)" \
		app-crypt/libsecret
}
