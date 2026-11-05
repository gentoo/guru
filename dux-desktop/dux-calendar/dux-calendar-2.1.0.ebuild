# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd xdg

DESCRIPTION="Calendar from Dux Labs"
HOMEPAGE="https://github.com/duxlabs-dev/dux-calendar"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3 go-module
	EGIT_REPO_URI="https://github.com/duxlabs-dev/${PN}.git"
else
	SRC_URI="https://github.com/duxlabs-dev/${PN}/releases/download/v${PV}/dankcalendar-${PV}.tar.gz"
	S="${WORKDIR}/dankcalendar-${PV}"

	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	dev-qt/qtdeclarative
	gui-apps/quickshell
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/go-1.27.1
"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		pushd "${S}/core" >& /dev/null || die
			ego mod vendor
		popd >& /dev/null || die
	else
		default
	fi
}

src_prepare(){
	default
	sed -i "s/-s -w //g" core/Makefile || die "failed to remove stripping of debug symbols"
}

src_compile() {
	cd core || die "Failed to cd"
	emake VERSION="${PV}" build
}

src_install() {
	emake DESTDIR="${ED}" PREFIX="/usr" install
	systemd_douserunit assets/systemd/dcal.service
}
