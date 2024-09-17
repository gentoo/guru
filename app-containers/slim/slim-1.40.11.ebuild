# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Inspect, optimize and debug containers"
HOMEPAGE="https://github.com/slimtoolkit/slim"
SRC_URI="
	https://github.com/slimtoolkit/slim/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ixti/slim/releases/download/${PV}/${P}-vendor.tar.xz
"

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-containers/docker
"

BDEPEND="
	>=dev-lang/go-1.22.0
"

src_compile() {
	LD_FLAGS+=" -s -w"
	LD_FLAGS+=" -X github.com/slimtoolkit/slim/pkg/version.appVersionTag=${PV}"
	LD_FLAGS+=" -X github.com/slimtoolkit/slim/pkg/version.appVersionRev=${PVR}"
	LD_FLAGS+=" -X github.com/slimtoolkit/slim/pkg/version.appVersionTime=$(date --utc '+%Y-%m-%d_%I:%M:%S%p')"

	ego generate github.com/slimtoolkit/slim/pkg/appbom

	pushd "${S}/cmd/slim"
		ego build -trimpath -ldflags="${LD_FLAGS}" -tags 'netgo osusergo' -o "${S}/slim"
	popd

	pushd "${S}/cmd/slim-sensor"
		ego build -trimpath -ldflags="${LD_FLAGS}" -tags 'netgo osusergo' -o "${S}/slim-sensor"
	popd
}

src_install() {
	dobin slim
	dobin slim-sensor
}
