EAPI=8
DESCRIPTION="Quick file creation without file paths"
HOMEPAGE="https://github.com/Chiron8/writedoc"
SRC_URI="https://github.com/Chiron8/writedoc/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
FEATURES="test"
RDEPEND="
app-shells/bash
app-editors/neovim
"
src_test() {
nvim -v >> /dev/null || die "neovim not installed"
}
src_install() {
install -Dm755 writedoc "${D}/usr/bin/writedoc" || die
install -Dm644 writedoc.1 "${D}/usr/share/man/man1/writedoc.1" || die
dodoc README.md
}
pkg_postinst() {
ewarn "Running post install tests"
# Have files that store defaults been created and are able to be written to?
writedoc -c -d / || ewarn "writedoc -c failed"
writedoc -c -t .c || ewarn "writedoc -c failed"
# Clean up
writedoc -r || ewarn "writedoc -r failed"
}
