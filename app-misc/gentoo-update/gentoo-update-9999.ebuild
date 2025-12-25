EAPI=8

inherit git-r3 cmake

DESCRIPTION="Update notifier and applier for Gentoo Linux"
HOMEPAGE="https://github.com/Techoraye/gentoo-update"
EGIT_REPO_URI="https://github.com/Techoraye/gentoo-update.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="gui"

RDEPEND="
	app-portage/gentoolkit
	sys-apps/portage
	gui? (
		dev-python/pyqt6
		x11-libs/libnotify
	)
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_GUI=$(usex gui)
	)
	cmake_src_configure
}
