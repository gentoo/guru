# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="$(ver_cut 1-2)"

inherit desktop unpacker xdg

DESCRIPTION="For converting between different versions of .dwg and .dxf"
HOMEPAGE="https://www.opendesign.com"

SRC_URI="https://www.opendesign.com/guestfiles/get?filename=ODAFileConverter_QT6_lnxX64_8.3dll_${MY_PV}.deb -> ${P}.deb"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	dev-qt/qtbase:6[gui,widgets]
	x11-themes/hicolor-icon-theme
"

DEPEND="${RDEPEND}"

BDEPEND="dev-util/patchelf"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/ODAFileConverter.*\\.desktop"

src_compile() {
	# Fix RPATH to point to the FHS-compliant installation directory
	patchelf --set-rpath \
		"/opt/ODAFileConverter" \
		"usr/bin/ODAFileConverter_${PV}/ODAFileConverter" \
		|| die "Failed to fix insecure RPATH"
	# Remove bundled qt.conf to use system Qt
	rm -f "usr/bin/ODAFileConverter_${PV}/qt.conf" || die "Failed to remove qt.conf"
}

src_install() {
	# Install main application files to /opt (FHS-compliant for self-contained binary packages)
	insinto /opt/ODAFileConverter
	doins -r "usr/bin/ODAFileConverter_${PV}"/*

	# Mark executables
	fperms 0755 /opt/ODAFileConverter/ODAFileConverter

	# Create wrapper script in /usr/bin
	newbin "${FILESDIR}"/ODAFileConverter ODAFileConverter

	# Create symlink for FreeCAD compatibility (auto-detects by "TeighaFileConverter" name)
	dosym ODAFileConverter /usr/bin/TeighaFileConverter

	# Install desktop file and icons
	domenu usr/share/applications/*.desktop
	doicon -s 16 usr/share/icons/hicolor/16x16/apps/ODAFileConverter.png
	doicon -s 32 usr/share/icons/hicolor/32x32/apps/ODAFileConverter.png
	doicon -s 64 usr/share/icons/hicolor/64x64/apps/ODAFileConverter.png
	doicon -s 128 usr/share/icons/hicolor/128x128/apps/ODAFileConverter.png
}
