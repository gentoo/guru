# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion systemd

DESCRIPTION="A simple daemon providing dynamic fan speed control"
HOMEPAGE="https://github.com/markusressel/fan2go"
SRC_URI="https://github.com/markusressel/fan2go/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/dsafxP/gentoo-distfiles/releases/download/${P}a/${P}-vendor.tar.xz"

LICENSE="AGPL-3"
# Dependent licenses
LICENSE+=" Apache-2.0 BSD ISC MIT"
SLOT="0"

KEYWORDS="~amd64"

DEPEND="sys-apps/lm-sensors"
RDEPEND="${DEPEND}"

src_compile() {
	local src_date_epoch=$(date +%s || die)
	local date=$(date -u -d @${src_date_epoch} +"%Y-%m-%dT%H:%M:%SZ" || die)
	local package=${HOMEPAGE#*://}

	ego build ${GOFLAGS} -v -x \
		-ldflags "-extldflags=-Wl,-z,lazy \
			-X ${PN}/cmd/global.Version=${PN} \
			-X ${package}/cmd/global.Version=${PN} \
			-X ${PN}/cmd/global.Date=${date} \
			-X ${package}/cmd/global.Date=${date}" \
		-tags netgo -o ${PN} main.go

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
