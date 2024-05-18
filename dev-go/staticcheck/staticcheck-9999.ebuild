# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="The advanced Go linter"
HOMEPAGE="https://staticcheck.io/"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dominikh/go-tools.git"
	RESTRICT="fetch mirror"
else
	SRC_URI="https://github.com/dominikh/go-tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" https://github.com/ran-dall/portage-deps/raw/master/${P}-deps.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	RESTRICT="mirror"
	S="${WORKDIR}/go-tools-${PV}"
fi

LICENSE="MIT"
SLOT="0"

IUSE="test"

DEPEND="dev-lang/go
		sys-libs/glibc"
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"

src_unpack() {
	default
	if [[ ${PV} == *9999 ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	fi
}

src_configure() {
	export CGO_ENABLED=1
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_CPPFLAGS="${CPPFLAGS}"
	export CGO_CXXFLAGS="${CXXFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"

	default
}

src_compile() {
	mkdir -pv bin || die
	ego build -ldflags "-linkmode=external" -o bin/"${PN}" "./cmd/staticcheck"
}

src_test() {
	GOROOT="${BROOT}/usr/lib/go" ego test -v -ldflags "-linkmode=external" ./...
}

src_install() {
	dobin bin/"${PN}"
}
