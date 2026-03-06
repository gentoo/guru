# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

DESCRIPTION="A simple daemon providing dynamic fan speed control"
HOMEPAGE="https://github.com/markusressel/fan2go-tui"
SRC_URI="https://github.com/markusressel/fan2go-tui/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/dsafxP/gentoo-distfiles/releases/download/${P}/${P}-vendor.tar.xz"

LICENSE="AGPL-3"
# Dependent licenses
LICENSE+=" Apache-2.0 BSD-2 BSD MIT MPL-2.0"
SLOT="0"

KEYWORDS="~amd64"

RDEPEND="sys-power/fan2go"

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

	insinto /etc/${PN}
	doins ${PN}.yaml

	newbashcomp "${PN}.bash" "${PN}"
	dofishcomp "${PN}.fish"
	newzshcomp "${PN}.zsh" "_${PN}"
}

pkg_postinst() {
	elog "You will need to enable fan2go API in its configuration"
}
