# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

DESCRIPTION="Game like benchmark (CPU, GPU), for ~5 minutes"
HOMEPAGE="https://benchmark.unigine.com/superposition"

SRC_URI="https://assets.unigine.com/d/Unigine_Superposition-${PV}.run"

LICENSE="Unigine-Superposition-Benchmark-EULA"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror strip"

BDEPEND="
	app-admin/chrpath
"

RDEPEND="
	dev-libs/glib:2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libxcb:=
"

QA_PREBUILT="
	opt/unigine-superposition/bin/qt/lib/libQt5QuickControls2.so.5
	opt/unigine-superposition/bin/qt/lib/libicudata.so.56
	opt/unigine-superposition/bin/qt/lib/libcrypto.so
	opt/unigine-superposition/bin/qt/lib/libQt5Widgets.so.5
	opt/unigine-superposition/bin/qt/lib/libicuuc.so.56
	opt/unigine-superposition/bin/qt/lib/libQt5Core.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5Xml.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5Concurrent.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5QuickTemplates2.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5WebSockets.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5XcbQpa.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5QuickTest.so.5
	opt/unigine-superposition/bin/qt/lib/libssl.so
	opt/unigine-superposition/bin/qt/lib/libQt5QuickWidgets.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5QuickParticles.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5Qml.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5Quick.so.5
	opt/unigine-superposition/bin/qt/lib/libicui18n.so.56
	opt/unigine-superposition/bin/qt/lib/libQt5DBus.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5Network.so.5
	opt/unigine-superposition/bin/qt/lib/libQt5Gui.so.5
	opt/unigine-superposition/bin/qt/plugins/platforms/libqxcb.so
	opt/unigine-superposition/bin/qt/plugins/xcbglintegrations/libqxcb-glx-integration.so
	opt/unigine-superposition/bin/qt/plugins/xcbglintegrations/libqxcb-egl-integration.so
	opt/unigine-superposition/bin/qt/qml/QtGraphicalEffects/libqtgraphicaleffectsplugin.so
	opt/unigine-superposition/bin/qt/qml/QtGraphicalEffects/private/libqtgraphicaleffectsprivate.so
	opt/unigine-superposition/bin/qt/qml/QtQuick/Window.2/libwindowplugin.so
	opt/unigine-superposition/bin/qt/qml/QtQuick/Templates.2/libqtquicktemplates2plugin.so
	opt/unigine-superposition/bin/qt/qml/QtQuick/Controls.2/libqtquickcontrols2plugin.so
	opt/unigine-superposition/bin/qt/qml/QtQuick/Layouts/libqquicklayoutsplugin.so
	opt/unigine-superposition/bin/qt/qml/QtQuick/Controls/libqtquickcontrolsplugin.so
	opt/unigine-superposition/bin/qt/qml/QtQuick/Dialogs/libdialogplugin.so
	opt/unigine-superposition/bin/qt/qml/QtQuick/Dialogs/Private/libdialogsprivateplugin.so
	opt/unigine-superposition/bin/qt/qml/QtQuick.2/libqtquick2plugin.so
	opt/unigine-superposition/bin/qt/qml/Qt/labs/settings/libqmlsettingsplugin.so
	opt/unigine-superposition/bin/qt/qml/Qt/labs/folderlistmodel/libqmlfolderlistmodelplugin.so
	opt/unigine-superposition/bin/superposition_cli
	opt/unigine-superposition/bin/libGPUMonitor_x64.so
	opt/unigine-superposition/bin/libUnigine_x64.so
	opt/unigine-superposition/bin/superposition
	opt/unigine-superposition/bin/libopenvr_api.so
	opt/unigine-superposition/bin/libopenal.so
	opt/unigine-superposition/bin/libAppVive_x64.so
	opt/unigine-superposition/bin/launcher
	opt/unigine-superposition/Superposition
"
QA_FLAGS_IGNORED="${QA_PREBUILT}"

src_unpack() {
	sh "${DISTDIR}"/Unigine_Superposition-1.1.run --tar xfv --one-top-level=${P} || die
}

src_install() {
	local res
	for res in 16 24 32 48 64 128 256
	do
		newicon -s ${res} icons/superposition_icon_${res}.png Superposition.png
	done

	rm -rf icons {post,un}install.sh version bin/qt/lib/libQt5QuickTest.so.5 || die
	# so.5 looks like unused lib https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=unigine-superposition#n76

	chrpath -r '$ORIGIN/qt/lib' bin/launcher || die
	# Against "scanelf: rpath_security_checks(): Security problem with relative DT_RPATH"

	insinto /opt/${PN}
	doins -r .

	fowners -R root:root /
	fperms +x /opt/${PN}/Superposition
	fperms +x /opt/${PN}/bin/launcher

	domenu "${FILESDIR}/Superposition.desktop"

	make_wrapper unigine-superposition /opt/${PN}/Superposition
}
