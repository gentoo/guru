# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

### A NOTE REGARDING PYTHON COMPATABILITY ###
# Anki-bin downloads a python 3.9 wheel. However the wheel used has only one native library _rsbridge.so
# that is not linked against libpython.
# The configuration with Python 3.{10..12} was tested on a limited number of machines and is not guaranteed to work.

PYTHON_COMPAT=( python3_{10..12} )
inherit desktop optfeature python-single-r1 pypi readme.gentoo-r1 xdg

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net/"
SRC_URI="
	$(pypi_wheel_url --unpack anki ${PV} cp39 abi3-manylinux_2_28_x86_64)
	$(pypi_wheel_url --unpack aqt ${PV})
	https://raw.githubusercontent.com/ankitects/anki/${PV}/qt/bundle/lin/anki.1 -> ${P}.1
	https://raw.githubusercontent.com/ankitects/anki/${PV}/qt/bundle/lin/anki.desktop -> ${P}.desktop
	https://raw.githubusercontent.com/ankitects/anki/${PV}/qt/bundle/lin/anki.png -> ${P}.png
	https://raw.githubusercontent.com/ankitects/anki/${PV}/qt/bundle/lin/anki.xpm -> ${P}.xpm
	https://raw.githubusercontent.com/ankitects/anki/${PV}/qt/bundle/lin/anki.xml -> ${P}.xml
"

# The program itself is licensed under AGPL-3+ with contributed portions licensed
# under BSD-3.
# The translation files are licensed under BSD-3 and public-domain.
# - ftl/
LICENSE="AGPL-3+ BSD public-domain"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 CC0-1.0 ISC MIT
	MPL-2.0 openssl Unicode-DFS-2016
"
# The supermemo importer is licensed under GPL-3+ and 0BSD.
# - pylib/anki/importing/supermemo_xml.py
#
# Anki bundles 3rd-party code and assets:
# The MathJax files are licensed under Apache-2.0.
# - node_modules/mathjax/es5/
#
# CSS Browser Selector is licensed under CC-BY-2.5.
# - node_modules/css-browser-selector/css_browser_selector.min.js
#
# The fancy deboss pattern is licensed under CC-BY-4.0.
# - pylib/anki/statsbg.py
#
# The patched MPV controls are licensed under MIT.
# - qt/aqt/mpv.py
#
# The Winpath module is licensed under MIT.
# - qt/aqt/winpaths.py
#
# The licenses for the runtime JS libaries are documented in the source code.
# - ts/licenses.json
# How to get an up-to-date summary:
# ./node_modules/.bin/license-checker-rseidelsohn --production --excludePackages anki --summary
#
# The vendored Flot plotting library is licensed under MIT.
# - qt/aqt/data/web/js/vendor/plot.js
LICENSE+=" 0BSD CC-BY-4.0 CC-BY-SA-2.5 GPL-3+ Unlicense"

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
	qt6? (  $(python_gen_cond_dep '
			   >=dev-python/PyQt6-6.5.0[gui,network,opengl,quick,svg,webchannel,widgets,${PYTHON_USEDEP}]
			   >=dev-python/PyQt6-sip-13.5.1[${PYTHON_USEDEP}]
			   >=dev-python/PyQt6-WebEngine-6.5.0[widgets,${PYTHON_USEDEP}]')

		 )
	!qt6? ( dev-qt/qtgui[jpeg,png]
			$(python_gen_cond_dep '
				>=dev-python/PyQt5-5.15.5[gui,network,svg,webchannel,widgets,${PYTHON_USEDEP}]
				>=dev-python/PyQt5-sip-12.9.0[${PYTHON_USEDEP}]
				>=dev-python/PyQtWebEngine-5.15.5[${PYTHON_USEDEP}]')

		  )
	${PYTHON_DEPS}
	!app-misc/anki
"
BDEPEND="app-arch/unzip"

S="${WORKDIR}"

DOC_CONTENTS="Users with add-ons that still rely on Anki's Qt5 GUI can either switch
to ${CATEGORY}/${PN}[-qt6], or temporarily set an environment variable
ENABLE_QT5_COMPAT to 1 to have Anki install the previous compatibility code.
The latter option has additional runtime dependencies. Please take a look
at this package's 'optional runtime features' for a complete listing.

In an early 2024 update, ENABLE_QT5_COMPAT will be removed, so this is not a
long term solution.

Anki's user manual is located online at https://docs.ankiweb.net/
Anki's add-on developer manual is located online at
https://addon-docs.ankiweb.net/
"

src_install() {
	python_domodule anki {,_}aqt *.dist-info
	printf "#!/usr/bin/python3\nimport sys;from aqt import run;sys.exit(run())" > runanki
	python_newscript runanki anki
	newicon "${DISTDIR}"/${P}.png anki.png
	newicon "${DISTDIR}"/${P}.xpm anki.xpm
	newmenu "${DISTDIR}"/${P}.desktop anki.desktop
	newman "${DISTDIR}"/${P}.1 anki.1
	insinto /usr/share/mime/packages
	newins "${DISTDIR}"/${P}.xml anki.xml

	local DISABLE_AUTOFORMATTING=1
	readme.gentoo_create_doc
}

pkg_postinst() {
	[[ "${REPLACING_VERSIONS%-r*}" != '23.10.1' ]] && local FORCE_PRINT_ELOG=1
	readme.gentoo_print_elog
	xdg_pkg_postinst
	optfeature "LaTeX in cards" "app-text/texlive[extra] app-text/dvipng"
	optfeature "sound support" media-video/mpv media-video/mplayer
	optfeature "recording support" "media-sound/lame[frontend] dev-python/PyQt$(usex qt6 6 5)[multimedia]"
	optfeature "faster database operations" dev-python/orjson
	use qt6 && optfeature "compatibility with Qt5-dependent add-ons" dev-python/PyQt6[dbus,printsupport]
	use qt6 && optfeature "Vulkan driver" "media-libs/vulkan-loader dev-qt/qtbase[vulkan]
							  dev-qt/qtdeclarative:6[vulkan] dev-qt/qtwebengine:6[vulkan]"

	einfo "You can customize the LaTeX header for your cards to fit your needs:"
	einfo "Notes > Manage Note Types > [select a note type] > Options"
}
