# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion systemd

# git rev-parse --short HEAD
MY_GIT_COMMIT="689a3f9"

DESCRIPTION="A simple daemon providing dynamic fan speed control"
HOMEPAGE="https://github.com/markusressel/fan2go"
SRC_URI="
	https://github.com/markusressel/fan2go/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/dsafxP/gentoo-distfiles/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="AGPL-3"
# Dependent licenses
LICENSE+=" Apache-2.0 BSD ISC MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="nvml"

BDEPEND=">=dev-lang/go-1.25.0"
DEPEND="sys-apps/lm-sensors"
RDEPEND="${DEPEND}
	nvml? ( x11-drivers/nvidia-drivers )
"

src_compile() {
	local src_date_epoch=$(date +%s || die)
	local date=$(date -u -d @${src_date_epoch} +"%Y-%m-%dT%H:%M:%SZ" || die)
	local package=${HOMEPAGE#*://}

	local mytags="netgo"

	use nvml || mytags+=",disable_nvml"

	local mygoargs=(
		-v -x
		-ldflags "-extldflags=-Wl,-z,lazy
			-X ${PN}/cmd/global.Version=${PV}
			-X ${package}/cmd/global.Version=${PV}
			-X ${PN}/cmd/global.Commit=${MY_GIT_COMMIT}
			-X ${package}/cmd/global.Commit=${MY_GIT_COMMIT}
			-X ${PN}/cmd/global.Date=${date}
			-X ${package}/cmd/global.Date=${date}"
		-tags "${mytags}"
		-o ${PN}
	)

	ego build "${mygoargs[@]}" main.go

	./${PN} completion fish > ${PN}.fish || die
	./${PN} completion bash > ${PN}.bash || die
	./${PN} completion zsh > ${PN}.zsh || die
}

src_install() {
	dobin ${PN}
	einstalldocs

	systemd_dounit fan2go.service

	insinto /etc/fan2go
	doins fan2go.yaml

	newbashcomp "${PN}.bash" "${PN}"
	dofishcomp "${PN}.fish"
	newzshcomp "${PN}.zsh" "_${PN}"
}
