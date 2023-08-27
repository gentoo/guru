# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

### A NOTE REGARDING PYTHON COMPATABILITY ###
# Anki-bin downloads a python 3.9 wheel. However the wheel used has only one native library _rsbridge.so
# that is not linked against libpython.
# The configuration with Python 3.{10,11} was tested on a limited number of machines and is not guaranteed to work.

PYTHON_COMPAT=( python3_{10..11} )
inherit desktop optfeature python-single-r1 pypi xdg

MY_PN=${PN%-bin}
DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net/"
SRC_URI="
	$(pypi_wheel_url --unpack ${MY_PN} ${PV} cp39 abi3-manylinux_2_28_x86_64)
	$(pypi_wheel_url --unpack aqt ${PV})
	https://raw.githubusercontent.com/ankitects/${MY_PN}/${PV}/qt/bundle/lin/${MY_PN}.desktop -> ${P}.desktop
	https://raw.githubusercontent.com/ankitects/${MY_PN}/${PV}/qt/bundle/lin/${MY_PN}.png -> ${P}.png
	https://raw.githubusercontent.com/ankitects/${MY_PN}/${PV}/qt/bundle/lin/${MY_PN}.1 -> ${P}.1
"

LICENSE="AGPL-3+ Apache-2.0 BSD CC-BY-3.0 GPL-3+ MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qt6"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

QA_PREBUILT="usr/lib/*"

RDEPEND="
app-misc/ca-certificates
$(python_gen_cond_dep '
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-cors[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
	dev-python/waitress[${PYTHON_USEDEP}]
	')

!qt6? (
		$(python_gen_cond_dep '
			>=dev-python/PyQt5-5.15.5[gui,network,webchannel,widgets,${PYTHON_USEDEP}]
			>=dev-python/PyQt5-sip-12.9.0[${PYTHON_USEDEP}]
			>=dev-python/PyQtWebEngine-5.15.5[${PYTHON_USEDEP}]
			')
		!dev-python/PyQt6
	  )

qt6? (
		$(python_gen_cond_dep '
			>=dev-python/PyQt6-6.5.0[dbus,gui,network,opengl,printsupport,webchannel,widgets,${PYTHON_USEDEP}]
			>=dev-python/PyQt6-sip-13.5.1[${PYTHON_USEDEP}]
			>=dev-python/PyQt6-WebEngine-6.5.0[widgets,${PYTHON_USEDEP}]
			')
	 )
	${PYTHON_DEPS}
	!app-misc/anki
"
BDEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	python_domodule anki {,_}aqt *.dist-info
	printf "#!/usr/bin/python3\nimport sys;from aqt import run;sys.exit(run())" > runanki
	python_newscript runanki anki
	newicon "${DISTDIR}"/${P}.png ${MY_PN}.png
	newmenu "${DISTDIR}"/${P}.desktop ${MY_PN}.desktop
	newman "${DISTDIR}"/${P}.1 ${MY_PN}.1
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "LaTeX in cards" "app-text/texlive[extra] app-text/dvipng"
	optfeature "sound support" media-video/mpv media-video/mplayer
	optfeature "recording support" "media-sound/lame[frontend] dev-python/PyQt$(usex qt6 6 5)[multimedia]"
	einfo "You can customize the LaTeX header for your cards to fit your needs:"
	einfo "Notes > Manage Note Types > Options"
}
