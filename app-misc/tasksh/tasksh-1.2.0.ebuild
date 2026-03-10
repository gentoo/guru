EAPI=8

inherit cmake

DESCRIPTION="Shell wrapper for Taskwarrior"
HOMEPAGE="https://gothenburgbitfactory.org/tasksh/"
SRC_URI="https://github.com/GothenburgBitFactory/taskshell/releases/download/v${PV}/tasksh-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/readline:0="
RDEPEND="
${DEPEND}
app-misc/task"
BDEPEND="virtual/pkgconfig"

DOCS=(
	AUTHORS
	ChangeLog
	NEWS
)

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	cmake_src_configure
}

src_install(){
	cmake_src_install
	rm -rf "${ED}/usr/share/doc/tasksh" || die
}
