# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A scheduler for CPU tasks"
HOMEPAGE="https://github.com/justanhduc/task-spooler"
if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/justanhduc/task-spooler.git"
else
	SRC_URI="https://github.com/justanhduc/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/task-spooler-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"

PATCHES=(
	"${FILESDIR}"/cmake-fixes-2.0.0.patch
	"${FILESDIR}"/cmake-bump-minver-2.0.0.patch
)

src_configure() {
	local mycmakeargs=(
		-DTASK_SPOOLER_COMPILE_CUDA=OFF
	)
	cmake_src_configure
}
