EAPI=8

CRATES=" "

inherit cargo

DESCRIPTION="A lightweight, external sidebar manager for the Niri window manager. "
HOMEPAGE="https://github.com/Vigintillionn/niri-sidebar"
SRC_URI="
	https://github.com/Vigintillionn/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.xz
	https://codeberg.org/ceres-sees-all/guru-distfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz
"

RUST_MIN_VER="1.87.0"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" GPL-3+ MIT MPL-2.0 Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

ECARGO_VENDOR="${WORKDIR}/vendor"
