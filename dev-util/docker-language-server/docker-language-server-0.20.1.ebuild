# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion optfeature

DESCRIPTION="Language server for Dockerfiles, Compose files, and Bake files"
HOMEPAGE="https://github.com/docker/docker-language-server"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/docker/docker-language-server.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/docker/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-go-mod-deps.tar.xz ->
	${P}-deps.tar.xz
	"
fi

LICENSE="Apache-2.0"
#gentoo-go-license docker-language-server-0.20.1.ebuild
LICENSE+=" Apache-2.0 BSD-2 BSD ISC MIT MPL-2.0 Unicode-DFS-2016 "
# dependency licenses
# if it says unknown license, and it's for in_toto, it's Apache-2.0
SLOT="0"
RESTRICT="test"
BDEPEND=">=dev-lang/go-1.25.0"
PATCHES=(
	"${FILESDIR}/telemetry-0.20.1.patch"
)
# the telemetry patch removes some unnessary bloat where the lsp would try to publish the telemetry (but will fail
# anyway because we don't have the api keys), otherwise i would actually use the telemetry use flag for this

src_unpack(){
	if [[ "${PV}" == 9999 ]];then
		git-r3_src_unpack
		go-module_live_vendor
	else
		default
	fi
}

src_compile(){
	local VERSION
	if [[ "${PV}" == 9999 ]]; then
		VERSION="$(git show -s --format=%cs)-$(git rev-parse --short HEAD)"
	else
		VERSION="${PV}"
	fi
	CGO_ENABLED=0 ego build \
		-ldflags="-s -w -X 'github.com/docker/docker-language-server/internal/pkg/cli/metadata.Version=${VERSION}'" \
		-o ./bin/"${PN}" ./cmd/"${PN}"
}

src_install(){
	dobin ./bin/"${PN}"
	./bin/"${PN}" completion bash > "${PN}" || die "generating bash completion failed"
	dobashcomp "${PN}"
	./bin/"${PN}" completion zsh > "_${PN}" || die "generating zsh completion failed"
	dozshcomp "_${PN}"
	./bin/"${PN}" completion fish > "${PN}.fish" || die "generating fish completion failed"
	dofishcomp "${PN}.fish"
}

pkg_postinst(){
	# at the time of writing this, it doesn't say what features, just some optional features
	# https://github.com/docker/docker-language-server/blob/5187ff578db630f5df5b5922a10d8415a5bb7d32/README.md?plain=1#L7
	optfeature "some optional features" app-containers/docker-buildx
}
