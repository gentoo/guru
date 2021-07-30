# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit python-single-r1 desktop xdg

MY_PN=${PN%-bin}
DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net/"
SRC_URI="
	https://files.pythonhosted.org/packages/cp38/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}-cp38-abi3-manylinux2014_x86_64.whl -> ${P}.zip
	https://files.pythonhosted.org/packages/py3/a/aqt/aqt-${PV}-py3-none-any.whl -> aqt-${PV}.zip
	https://raw.githubusercontent.com/ankitects/anki/${PV}/qt/linux/anki.png
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
