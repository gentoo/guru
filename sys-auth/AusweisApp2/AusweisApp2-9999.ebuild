# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Official authentication app for German ID cards and residence permits"
HOMEPAGE="https://www.ausweisapp.bund.de/"
EGIT_REPO_URI="https://github.com/Governikus/AusweisApp2.git"

LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="virtual/pkgconfig"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwebsockets:5[qml]
	dev-qt/qtquickcontrols2:5
	dev-qt/qtwidgets:5
	dev-libs/openssl:0=
	sys-apps/pcsc-lite
	net-libs/http-parser"

DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

src_prepare() {
	cmake_src_prepare
	eautoreconf
}

src_configure() {
	# get rid of QA Notice: The following files contain insecure RUNPATHs
	local mycmakeargs=( -DCMAKE_SKIP_RPATH=ON )
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dolib.so "${BUILD_DIR}"/src/activation/base/libAusweisAppActivation.so
	dolib.so "${BUILD_DIR}"/src/activation/customscheme/libAusweisAppActivationCustomScheme.so
	dolib.so "${BUILD_DIR}"/src/activation/intent/libAusweisAppActivationIntent.so
	dolib.so "${BUILD_DIR}"/src/activation/internal/libAusweisAppActivationInternal.so
	dolib.so "${BUILD_DIR}"/src/activation/webservice/libAusweisAppActivationWebservice.so
	dolib.so "${BUILD_DIR}"/src/card/base/libAusweisAppCard.so
	dolib.so "${BUILD_DIR}"/src/card/drivers/libAusweisAppCardDrivers.so
	dolib.so "${BUILD_DIR}"/src/card/pcsc/libAusweisAppCardPcsc.so
	dolib.so "${BUILD_DIR}"/src/configuration/libAusweisAppConfiguration.so
	dolib.so "${BUILD_DIR}"/src/core/libAusweisAppCore.so
	dolib.so "${BUILD_DIR}"/src/export/libAusweisAppExport.so
	dolib.so "${BUILD_DIR}"/src/file_provider/libAusweisAppFileProvider.so
	dolib.so "${BUILD_DIR}"/src/global/libAusweisAppGlobal.so
	dolib.so "${BUILD_DIR}"/src/init/libAusweisAppInit.so
	dolib.so "${BUILD_DIR}"/src/network/libAusweisAppNetwork.so
	dolib.so "${BUILD_DIR}"/src/remote_device/libAusweisAppRemoteDevice.so
	dolib.so "${BUILD_DIR}"/src/secure_storage/libAusweisAppSecureStorage.so
	dolib.so "${BUILD_DIR}"/src/services/libAusweisAppServices.so
	dolib.so "${BUILD_DIR}"/src/settings/libAusweisAppSettings.so
	dolib.so "${BUILD_DIR}"/src/ui/aidl/libAusweisAppUiAidl.so
	dolib.so "${BUILD_DIR}"/src/ui/base/libAusweisAppUi.so
	dolib.so "${BUILD_DIR}"/src/ui/common/libAusweisAppUiCommon.so
	dolib.so "${BUILD_DIR}"/src/ui/json/libAusweisAppUiJson.so
	dolib.so "${BUILD_DIR}"/src/ui/qml/libAusweisAppUiQml.so
	dolib.so "${BUILD_DIR}"/src/ui/websocket/libAusweisAppUiWebsocket.so
	dolib.so "${BUILD_DIR}"/src/ui/widget/libAusweisAppUiWidget.so
	dolib.so "${BUILD_DIR}"/src/whitelist_client/libAusweisAppWhitelistClient.so
}
