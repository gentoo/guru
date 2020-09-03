# EBUILD file for vlang/v

EAPI=7
DESCRIPTION="Simple, fast, safe compiled language for developing maintainable software."
HOMEPAGE="https://vlang.io"
LICENSE="MIT"

SRC_URI="https://github.com/vlang/v"

SLOT="0"

KEYWORDS="~amd64"

src_compile(){
  cd v && make
  # Adds to PATH via symlink
  ./v symlink
}
