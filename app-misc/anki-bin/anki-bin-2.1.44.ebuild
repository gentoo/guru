# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit python-single-r1 desktop xdg

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net/"
SRC_URI="
	https://files.pythonhosted.org/packages/1d/da/199c378dd483bea4b38e94c2951bbb903dae8be023484577ba41b9c75ada/anki-2.1.44-cp38-abi3-manylinux2014_x86_64.whl -> ${P}.zip
	https://files.pythonhosted.org/packages/25/1a/7b94d38b897c942c206258b7b1c758586250ebeb4804a33a4191a047fb2a/aqt-2.1.44-py3-none-any.whl -> aqt-${PV}.zip
	https://github.com/ankitects/anki/blob/2.1.44/qt/linux/anki.png
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/decorator
	dev-python/protobuf-python
	dev-python/orjson-bin
	dev-python/distro
	dev-python/beautifulsoup
	dev-python/requests
	dev-python/flask
	dev-python/waitress
	dev-python/send2trash
	dev-python/markdown
	dev-python/jsonschema
	dev-python/flask-cors
	dev-python/PyQt5
	dev-python/PyQtWebEngine
"
RDEPEND="
	${DEPEND}
	!app-misc/anki
"
BDEPEND="app-arch/unzip
${PYTHON_DEPS}"

S="${WORKDIR}"

src_unpack() {
	default
}

src_install() {
	python_domodule anki
	python_domodule anki-2.1.44.dist-info
	python_domodule aqt
	python_domodule aqt-${PV}.dist-info
	printf "#!/usr/bin/python3\nimport sys;from aqt import run;sys.exit(run())" > runanki
	python_newscript runanki anki
	doicon "${DISTDIR}"/anki.png
	make_desktop_entry /usr/bin/anki Anki anki Education
}
