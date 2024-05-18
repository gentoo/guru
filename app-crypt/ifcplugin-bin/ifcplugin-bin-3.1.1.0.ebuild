# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo rpm

DESCRIPTION="Crypto Interface Web Browser Plugin"
HOMEPAGE="https://ds-plugin.gosuslugi.ru"
REDOS_URI="http://repo.red-soft.ru/redos/7.3/x86_64/updates"
SRC_URI="
	amd64? (
		${REDOS_URI}/ifcplugin-${PV}-2.el7.x86_64.rpm
		${REDOS_URI}/ifcplugin-chromium-${PV}-2.el7.x86_64.rpm
		${REDOS_URI}/ifcplugin-firefox-${PV}-2.el7.x86_64.rpm
		${REDOS_URI}/ifcplugin-libs-${PV}-2.el7.x86_64.rpm
	)
	x86? (
		${REDOS_URI}/ifcplugin-${PV}-2.el7.i686.rpm
		${REDOS_URI}/ifcplugin-chromium-${PV}-2.el7.i686.rpm
		${REDOS_URI}/ifcplugin-firefox-${PV}-2.el7.i686.rpm
		${REDOS_URI}/ifcplugin-libs-${PV}-2.el7.i686.rpm
	)
"
S="${WORKDIR}"

LICENSE="LGPL-2.1 MIT freedist openssl"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-apps/pcsc-lite"

QA_PREBUILT="*"
QA_SONAME_NO_SYMLINK=".*"

src_prepare() {
	default

	rm usr/lib/mozilla/plugins/IFCPlugin.so || die
	find . -name '*_license' -delete || die
	find -L . -wholename '*/.build-id/*' -delete || die
}

src_install() {
	mkdir -p "${ED}" || die
	cp -a "${WORKDIR}"/* "${ED}" || die

	diropts --mode 777
	keepdir /var/log/ifc
	keepdir /var/log/ifc/engine_logs
}

pkg_postinst() {
	cd "${EPREFIX}"/etc/update_ccid_boundle || die
	edo bash update_ccid_boundle.sh
}
