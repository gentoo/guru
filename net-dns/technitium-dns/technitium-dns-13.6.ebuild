# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT=8.0
NUGETS="BouncyCastle.Cryptography@2.5.1"
inherit dotnet-pkg systemd

MYPV="${PV}.0"
DESCRIPTION="Open-source, self-hosted authoritative and recursive DNS+DHCP server."
HOMEPAGE="https://technitium.com/dns/"
SRC_URI="
	https://github.com/TechnitiumSoftware/DnsServer/archive/refs/tags/v${MYPV}.tar.gz -> TechnitiumDnsServer-${MYPV}.tar.gz
	https://github.com/TechnitiumSoftware/TechnitiumLibrary/archive/refs/tags/dns-server-v${MYPV}.tar.gz -> TechnitiumLibrary-${MYPV}.tar.gz
	${NUGET_URIS}
"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND=">=dev-libs/icu-70"

DOTNET_PKG_PROJECTS=(
	"${S}/TechnitiumLibrary-dns-server-v${MYPV}/TechnitiumLibrary.ByteTree/TechnitiumLibrary.ByteTree.csproj"
	"${S}/TechnitiumLibrary-dns-server-v${MYPV}/TechnitiumLibrary.Net/TechnitiumLibrary.Net.csproj"
	"${S}/DnsServer-${MYPV}/DnsServerApp/DnsServerApp.csproj"
)

src_prepare() {
	default
	dotnet-pkg_src_prepare

	# The DnsServer project expects to find TechnitiumLibrary DLLs in a
	# directory sibling to the root of the project, so has `HintPath`
	# directives to point to that relative path (e.g.,
	# '..\..\TechnitiumLibrary\bin\TechnitiumLibrary.dll'). Because we're
	# explicitly building into `DOTNET_PKG_OUTPUT`, we'll need to point there
	# instead for the DLLs to be located.
	local replace_hintpaths="s|<HintPath>(\\.\\.\\\\)*TechnitiumLibrary\\\\bin|<HintPath>${DOTNET_PKG_OUTPUT}|g"
	grep -ErlZ 'HintPath.*TechnitiumLibrary' "${S}/DnsServer-${MYPV}" \
		| xargs -0 sed -E -i "${replace_hintpaths}" \
		|| die
}

src_install() {
	default

	# dotnet-pkg will create a wrapper script around an executable at the root
	# of `DOTNET_PKG_OUTPUT` matching `${PN}`, so we can link to
	# `DnsServerApp`.
	cd "${DOTNET_PKG_OUTPUT}" && ln -rs 'DnsServerApp' "${PN}" || die

	# The included `systemd.service` file has hard-coded paths we'd need to
	# adjust; we'll install our own.
	rm "${DOTNET_PKG_OUTPUT}/systemd.service"

	dotnet-pkg_src_install

	newinitd "${FILESDIR}/${PF}.initd" "${PN}"
	systemd_newunit "${FILESDIR}/${PF}.service" "${PN}.service"
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog 'To start Technitium DNS:'
		elog '* OpenRC: rc-update add technitium-dns boot'
		elog '          rc-service technitium-dns start'
		elog '  OR'
		elog '* systemd: systemctl enable technitium-dns'
		elog '           systemctl start technitium-dns'
		elog
		elog 'After starting the service,'
		elog '1. Technitium DNS configuration files can be found in'
		elog "   \"${ROOT}/etc/dns\""
		elog '2. The Technetium web server can be accessed at localhost:5380. This port'
		elog '   can be adjusted in settings'
	fi
}

pkg_postrm() {
	if [[ -d "${ROOT}/etc/dns" ]]; then
		elog "Technitium DNS config files may still be present in \"${ROOT}/etc/dns\""
	fi
}
