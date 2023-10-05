# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion systemd

DESCRIPTION="A simple daemon providing dynamic fan speed control"
SRC_URI="https://github.com/markusressel/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gentoo.kropotkin.rocks/go-pkgs/${P}-vendor.tar.xz"
HOMEPAGE="https://github.com/markusressel/fan2go"

LICENSE="AGPL-3 Apache-2.0 MIT BSD BSD-2 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-apps/lm-sensors"
RDEPEND="${DEPEND}"

src_compile() {
	SOURCE_DATE_EPOCH=$(date +%s || die)
	DATE=$(date -u -d @${SOURCE_DATE_EPOCH} +"%Y-%m-%dT%H:%M:%SZ" || die)

	ego \
		build \
		-o fan2go \
		-x \
		-v \
		${GOFLAGS} \
		-ldflags "-X fan2go/cmd.version=${PV} -X fan2go/cmd.date=${DATE}" \
		-a \
		-tags netgo \
		.

	./fan2go completion fish > fan2go.fish || die
	./fan2go completion bash > fan2go.bash || die
	./fan2go completion zsh > fan2go.zsh || die
}

src_install() {
	dobin fan2go
	dodoc README.md
	systemd_dounit fan2go.service
	insinto /etc/fan2go
	doins fan2go.yaml
	newbashcomp "${PN}.bash" "${PN}"
	dofishcomp "${PN}.fish"
	newzshcomp "${PN}.zsh" "_${PN}"
}

src_test() {
	go test -v ./... || die
}
