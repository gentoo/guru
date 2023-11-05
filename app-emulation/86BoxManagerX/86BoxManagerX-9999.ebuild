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

QA_PRESTRIPPED="
	/opt/86BoxManagerX/createdump
	/opt/86BoxManagerX/libSystem.Globalization.Native.so
	/opt/86BoxManagerX/libSystem.IO.Compression.Native.so
	/opt/86BoxManagerX/libSystem.Native.so
	/opt/86BoxManagerX/libSystem.Net.Security.Native.so
	/opt/86BoxManagerX/libSystem.Security.Cryptography.Native.OpenSsl.so
	/opt/86BoxManagerX/libclrjit.so
	/opt/86BoxManagerX/libcoreclr.so
	/opt/86BoxManagerX/libcoreclrtraceptprovider.so
	/opt/86BoxManagerX/libdbgshim.so
	/opt/86BoxManagerX/libhostfxr.so
	/opt/86BoxManagerX/libhostpolicy.so
	/opt/86BoxManagerX/libmscordaccore.so
	/opt/86BoxManagerX/libmscordbi.so
	/opt/86BoxManagerX/libHarfBuzzSharp.so
	/opt/86BoxManagerX/libMono.Unix.so
	/opt/86BoxManagerX/libSkiaSharp.so
	/opt/86BoxManagerX/86Manager
"

LICENSE="MIT"
SLOT="0"

PATCHES=(
	# Save the config in user directory preventing permission denied error
	# https://github.com/RetBox/86BoxManagerX/pull/1
	"${FILESDIR}/86BoxManagerX-9999-save-config-user-directory.patch"
)

src_unpack() {
	git-r3_checkout
	cd "${S}"
	# Need internet access
	dotnet publish 86BoxManager -r linux-x64
}

src_prepare() {
	default
}

src_compile() {
	dotnet publish 86BoxManager -r linux-x64 -c Release --self-contained true -o 86BoxManagerX
}

src_install() {
	#Install binary and alias command
	insinto /opt && doins -r "${WORKDIR}/${P}/86BoxManagerX"
	insinto /opt/bin/ && doins "${FILESDIR}/86BoxManagerX"
	fperms +x /opt/86BoxManagerX/86Manager /opt/bin/86BoxManagerX
	find /opt/86BoxManagerX/ -name "*.dll" -exec fperms +x {} +

	#Icon and Desktop File
	doicon "${FILESDIR}/86BoxManagerX.png"
	domenu "${FILESDIR}/86BoxManagerX.desktop"
}
