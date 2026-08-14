# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="AMD container runtime toolkit"
HOMEPAGE="https://github.com/ROCm/container-toolkit"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ROCm/container-toolkit.git"
else
	SRC_URI="
		https://github.com/ROCm/container-toolkit/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/vowstar/vowstar-overlay-dist/releases/download/${PN}-${PV}/${P}-deps.tar.xz
	"
	S="${WORKDIR}/container-toolkit-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0/${PV}"

# Tests may require specific environmental setups or additional hardware.
RESTRICT="test"

src_compile() {
	# Skip 'gen' and 'checks' targets which require network access
	# to download golangci-lint and goimports.
	GOMODCACHE="${WORKDIR}/go-mod" GOFLAGS="-mod=mod" \
		emake container-toolkit container-toolkit-ctk
}

src_install() {
	dobin bin/deb/amd-container-runtime \
		bin/deb/amd-ctk
}

pkg_postinst() {
	elog "Your docker or containerd (if applicable) service may need restart"
	elog "after install this package:"
	elog "OpenRC: rc-service containerd restart; rc-service docker restart"
	elog "systemd: systemctl restart containerd; systemctl restart docker"
	elog ""
	elog "To configure the AMD container runtime for Docker, run:"
	elog "  sudo amd-ctk runtime configure --runtime=docker"
	elog "  sudo systemctl restart docker"
	elog ""
	elog "For more details, see:"
	elog "  https://instinct.docs.amd.com/projects/container-toolkit/en/latest/"
}
