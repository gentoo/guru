# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit python-single-r1 desktop xdg

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net/"
SRC_URI="
	https://files.pythonhosted.org/packages/1d/da/199c378dd483bea4b38e94c2951bbb903dae8be023484577ba41b9c75ada/anki-${PV}-cp38-abi3-manylinux2014_x86_64.whl -> ${P}.zip
	https://files.pythonhosted.org/packages/25/1a/7b94d38b897c942c206258b7b1c758586250ebeb4804a33a4191a047fb2a/aqt-${PV}-py3-none-any.whl -> aqt-${PV}.zip
	https://github.com/ankitects/anki/blob/${PV}/qt/linux/anki.png
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	$(python_gen_cond_dep '
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
	dev-python/orjson-bin[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/beautifulsoup[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/waitress[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/flask-cors[${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/PyQtWebEngine[${PYTHON_USEDEP}]
	')
"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	!app-misc/anki
"
BDEPEND="app-arch/unzip"

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
