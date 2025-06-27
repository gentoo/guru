# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

MY_PN="NotepadNext"
COMMIT_SINGLEAPPLICATION="8c48163c4d3fbba603cfe8a5b94046c9dad71825"
COMMIT_UCHARDET="59f68dbe5709d708b53ad5ea95c7349d7ee6ebe4"
COMMIT_EDITORCONFIG="52820d59769fcba6d0ed94f685406c0383fe1a30"
COMMIT_QADS="df1fa271274be04f9704f6d67eb2294c03256208"
COMMIT_QSIMPLEUPDATER="3cc832cbe55b70c54f56a0b9b6f2cdd3c43c2337"

DESCRIPTION="A cross-platform reimplementation of Notepad++ based on Qt"
HOMEPAGE="https://github.com/dail8859/NotepadNext"
SRC_URI="
	https://github.com/dail8859/NotepadNext/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${COMMIT_SINGLEAPPLICATION}.tar.gz
		-> SingleApplication-${COMMIT_SINGLEAPPLICATION}.tar.gz
	https://gitlab.freedesktop.org/uchardet/uchardet/-/archive/${COMMIT_UCHARDET}.tar.gz
		-> uchardet-${COMMIT_UCHARDET}.tar.gz
	https://github.com/editorconfig/editorconfig-core-qt/archive/${COMMIT_EDITORCONFIG}.tar.gz
		-> editorconfig-core-qt-${COMMIT_EDITORCONFIG}.tar.gz
	https://github.com/githubuser0xFFFF/Qt-Advanced-Docking-System/archive/${COMMIT_QADS}.tar.gz
		-> Qt-Advanced-Docking-System-${COMMIT_QADS}.tar.gz
	https://github.com/alex-spataru/QSimpleUpdater/archive/${COMMIT_QSIMPLEUPDATER}.tar.gz
		-> QSimpleUpdater-${COMMIT_QSIMPLEUPDATER}.tar.gz
"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
# submodule licenses
LICENSE+=" MIT LGPL-2.1 MIT-no-machine-learning || ( MPL-1.1 GPL-2+ LGPL-2.1+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/libxcb:=
	dev-qt/qtbase:6[gui,network,widgets]
	dev-qt/qt5compat:6
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/qttools:6
"

src_prepare() {
	default
	mv -T "${WORKDIR}"/QSimpleUpdater-"${COMMIT_QSIMPLEUPDATER}" "${S}"/src/QSimpleUpdater || die
	mv -T "${WORKDIR}"/Qt-Advanced-Docking-System-"${COMMIT_QADS}" "${S}"/src/ads || die
	mv -T "${WORKDIR}"/editorconfig-core-qt-"${COMMIT_EDITORCONFIG}" "${S}"/src/editorconfig-core-qt || die
	mv -T "${WORKDIR}"/SingleApplication-"${COMMIT_SINGLEAPPLICATION}" "${S}"/src/singleapplication || die
	mv -T "${WORKDIR}"/uchardet-"${COMMIT_UCHARDET}" "${S}"/src/uchardet || die

	sed -i '1i #include <cstdint>' "${S}"/src/scintilla/include/ScintillaTypes.h || die
}

src_configure() {
		eqmake6 src/NotepadNext.pro
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
}
