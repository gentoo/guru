# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/Snawoot/extip v1.0.0/go.mod"
	"github.com/Snawoot/extip v1.0.0"
	"gortc.io/stun v1.22.2/go.mod"
	"gortc.io/stun v1.22.2"
)
go-module_set_globals

DESCRIPTION="Get your external IP address using STUN server"
HOMEPAGE="https://github.com/Snawoot/myip"
EGO_PN="github.com/Snawoot/${PN}"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
${EGO_SUM_SRC_URI}"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dobin bin/*
}
