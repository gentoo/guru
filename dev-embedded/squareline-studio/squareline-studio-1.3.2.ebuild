# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

MY_PV="$(ver_rs 1- '_')"

inherit desktop xdg

DESCRIPTION="Visual drag-and-drop UI editor for LVGL"
HOMEPAGE="https://squareline.io"
SRC_URI="
	https://static.squareline.io/downloads/SquareLine_Studio_Linux_v${MY_PV}.zip -> ${P}.zip
"

LICENSE="all-rights-reserved"
KEYWORDS="-* ~amd64"
SLOT="0/${PV}"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="
	app-arch/unzip
"

S="${WORKDIR}"
QA_PREBUILT="*"

src_install() {
	# desktop entry
	sed "s|__folder__|/opt/${P}|g" squareline_studio.desktop.template > "${P}.desktop" || die
	# install
	insinto "/opt/${P}"
	doins -r *
	for x in $(find .) ; do
		# Fix python script permissions
		[[ "${x: -3}" == ".py" ]] && fperms 0755 "/opt/${P}/${x}"
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] && fperms 0755 "/opt/${P}/${x}"
	done
	domenu "${P}.desktop"
	dosym ../../opt/"${P}"/"SquareLine_Studio.x86_64" /usr/bin/"${P}"
}
