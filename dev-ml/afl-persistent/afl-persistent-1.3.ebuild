# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit opam

DESCRIPTION="Persistent-mode afl-fuzz for ocaml"
HOMEPAGE="https://github.com/stedolan/ocaml-afl-persistent"
SRC_URI="https://github.com/stedolan/ocaml-afl-persistent/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-ml/base-unix"
DEPEND="${RDEPEND}"

src_compile() {
	./build.sh || die
}
