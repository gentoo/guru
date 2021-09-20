# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
MY_PN=${PN%-*}

inherit desktop python-single-r1 xdg

DESCRIPTION="Web based tool to extract data from plots, images, and maps"
HOMEPAGE="https://automeris.io/WebPlotDigitizer/"
SRC_URI="https://automeris.io/downloads/${MY_PN}-${PV}-linux-x64.zip"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
#RESTRICT="strip"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

QA_PREBUILT="
	*/libGLESv2.so
	*/libEGL.so
	*/libffmpeg.so
	*/libvk_swiftshader.so
	*/${MY_PN}-${PV}
	"

## RDEPEND is still required to be filled with actual runtime-deps:
## python is just assumed runtime-dependency.
RDEPEND="
	${PYTHON_DEPS}
	dev-libs/nss
	x11-libs/gtk+:3[X,cups,introspection]
"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_PN}-${PV}-linux-x64"

QA_FLAGS_IGNORED="
	/opt/${P}/chrome-sandbox
	/opt/${P}/libvulkan.so*
"

## It seems media-libs/alsa-lib is required by chrome-sandbox.
## Actually this library isn't required to work.
QA_SONAME="
	/usr/lib*/libasound.so.2
"

src_install() {
	insinto "/opt/${P}"
	doins -r "${S}/."

	exeinto "/opt/${P}"
	doexe "/${S}/${MY_PN}-${PV}"
	dosym ../../opt/"${MY_PN}"-bin-"${PV}/${MY_PN}-${PV}" /usr/bin/"${PN}"

	newicon "/${S}/resources/app/images/icon/icon.png" ${PN}-icon.png

	make_desktop_entry "/opt/${P}/${MY_PN}-${PV}" "${MY_PN}" "${PN}-icon" "Graphics"
	## After opening via xdg-open the js scripts could not work (i.e. "File - Load Image" menu)
	make_desktop_entry "/usr/bin/xdg-open /opt/${P}/resources/app/index.html" "${MY_PN} html" "viewhtml" "Graphics"
}
