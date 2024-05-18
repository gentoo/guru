EAPI=8

inherit meson

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kernaltrap8/tinyfetch"
	S="${WORKDIR}/${PN}-9999"
fi

DESCRIPTION="fetch program written in pure C"
HOMEPAGE="https://github.com/kernaltrap8/tinyfetch"

LICENSE="GPL-3"
SLOT="0"

DEPEND="${BDEPEND}"
BDEPEND="
	dev-build/meson
"

src_configure() {
	meson_src_configure
}
