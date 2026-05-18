EAPI="8"

inherit go-module

DESCRIPTION="A task runner / simpler Make alternative written in Go"
HOMEPAGE="https://taskfile.dev"
SRC_URI="https://github.com/${PN}/task/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://git.skysolutions.fi/gentoo-mirror/guru-vendored/releases/download/go-task-${PV}/go-task-${PV}-deps.tar.xz"
S="${WORKDIR}/task-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

src_compile() {
	ego build github.com/go-task/task/v3/cmd/task
}

src_install() {
	dobin task

	default
}
