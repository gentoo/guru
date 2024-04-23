# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic pam systemd

DESCRIPTION="Lightweight Music Server."
HOMEPAGE="http://lms-demo.poupon.dev/ https://github.com/epoupon/lms"
SRC_URI="https://github.com/epoupon/lms/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test stb"
RESTRICT="!test? ( test )"

RDEPEND="
	acct-user/lms
	dev-cpp/wt
	dev-libs/boost
	dev-libs/libconfig[cxx]
	media-libs/taglib
	media-video/ffmpeg[mp3,opus]

	!stb? ( media-gfx/graphicsmagick )

"

DEPEND="
	${RDEPEND}

	stb? ( dev-libs/stb )
"

BDEPEND="
	test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/${PN}-respect-ldflags.patch"
)

src_configure() {
	append-flags -I/usr/include/stb/deprecated

	local mycmakeargs=(
		-DIMAGE_LIBRARY=$(usex stb STB GraphicsMagick++)
		-DENABLE_TESTS=$(usex test)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	systemd_newunit conf/systemd/default.service lms.service
	newinitd "${FILESDIR}/lms.init" lms
	dopamd conf/pam/lms
	mv "${ED}/usr/share/lms/lms.conf" "${ED}/etc/lms.conf" || die

	# Already installed in the proper directory
	rm "${ED}/usr/share/lms/default.service" || die
	rm "${ED}/usr/share/lms/lms" || die

	keepdir /var/log/lms
	fowners -R lms:lms /var/log/lms

	keepdir /var/lms
	fowners lms:lms /var/lms
}
