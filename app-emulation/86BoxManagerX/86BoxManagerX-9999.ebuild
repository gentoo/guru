# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop git-r3
EGIT_REPO_URI="https://github.com/RetBox/86BoxManagerX.git"
DESCRIPTION="A (cross-platform) configuration manager for the 86Box emulator"
HOMEPAGE="https://github.com/RetBox/86BoxManagerX"

DEPEND="app-emulation/86Box
	dev-dotnet/dotnet-sdk-bin
"

LICENSE="MIT"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	cd "${S}"
	dotnet publish 86BoxManager -r linux-x64
}

src_compile () {
	dotnet publish 86BoxManager -r linux-x64 -c Release --self-contained true -o 86BoxManagerX
}

src_install() {
	#Install binary and alias command
	insinto /opt && doins -r "${WORKDIR}/${P}/86BoxManagerX"
	insinto /opt/bin/ && doins "${FILESDIR}/86BoxManagerX"
	fperms +x /opt/86BoxManagerX/86Manager /opt/bin/86BoxManagerX /opt/86BoxManagerX/*.dll

	#Icon and Desktop File
	doicon "${FILESDIR}/86BoxManagerX.png"
	domenu "${FILESDIR}/86BoxManagerX.desktop"
}
