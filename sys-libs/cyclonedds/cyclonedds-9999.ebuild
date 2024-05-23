# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Eclipse Cyclone DDS project"
HOMEPAGE="https://cyclonedds.io/"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/eclipse-cyclonedds/cyclonedds.git"
	inherit git-r3
else
	SRC_URI="https://github.com/eclipse-cyclonedds/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="EPL-2.0"
SLOT="0/$(ver_cut 1-2)"
IUSE="test ssl shm parser doc examples ipv6 idlc get-kind"
RESTRICT="!test? ( test )"

RDEPEND=(
	"doc? ( app-text/doxygen )"
	"ssl? ( dev-libs/openssl )"
	"shm? ( sys-libs/iceoryx )"
	"parser? ( sys-devel/bison )"
)
DEPEND="${RDEPEND[@]}"

CMAKE_BUILD_TYPE=Release

src_prepare() {
	use get-kind && eapply "${FILESDIR}/${PN}-0.10.3-get_kind.patch"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCS= $(usex doc)
		-DBUILD_DDSPERF=OFF
		-DBUILD_EXAMPLES=$(usex examples)
		-DBUILD_TESTING=$(usex test)
		-DBUILD_IDLC_TESTING=$(usex test)
		-DBUILD_IDLC=$(usex idlc)
		-DENABLE_SSL=$(usex ssl)
		-DENABLE_SECURITY=$(usex ssl)
		-DENABLE_SECURITY=$(usex ssl)
		-DENABLE_IPV6=$(usex ipv6)
		-DENABLE_SHM=$(usex shm)
	)
	cmake_src_configure
}
