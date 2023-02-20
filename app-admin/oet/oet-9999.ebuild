EAPI=8

DESCRIPTION="Update your system into binpkgs in an overlay sandbox"
HOMEPAGE="https://codeberg.org/bcsthsc/overlay-emerge-tool"
if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/bcsthsc/overlay-emerge-tool.git"
	EGIT_BRANCH="0.0.0.1"
	[[ "${PV}" == "9999" ]] && EGIT_BRANCH=0.0.0.1
	[[ "${EGIT_BRANCH}" == "" ]] && die "Please set a git branch"
else
	SRC_URI="https://codeberg.org/bcsthsc/overlay-emerge-tool/archive/oet-${PV}.tar.gz"
	S="${WORKDIR}/oet-${PV/_rc/-rc.}"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


src_install() {
	dosbin src/oet.sh
	dodir /usr/share/oet
	insinto /usr/share/oet
	doins src/oet_auto_emerge_update.source
	doins src/oet_interactive.source
}

src_compile() {
	true
}
