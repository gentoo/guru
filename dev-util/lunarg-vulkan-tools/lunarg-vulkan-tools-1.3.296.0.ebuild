EAPI=8

MY_PN=VulkanTools

inherit cmake

DESCRIPTION="Vulkan ecosystem tools and extra layers by LunarG."
HOMEPAGE="https://github.com/LunarG/VulkanTools/"

SRC_URI="
	https://github.com/LunarG/${MY_PN}/archive/vulkan-sdk-${PV}.tar.gz -> ${P}.tar.gz
"

S="${WORKDIR}"/${MY_PN}-vulkan-sdk-${PV}

LICENSE="Apache-2.0"
SLOT="0"

KEYWORDS="~amd64"

DEPEND="
	dev-cpp/valijson
	dev-util/vulkan-headers
	dev-util/vulkan-utility-libraries"

BDEPEND="
	>=dev-build/cmake-3.17.2"

RDEPEND="
	dev-libs/jsoncpp:=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	media-libs/vulkan-loader"

src_prepare() {
	# remove valijson find_package to properly use system valijson
	eapply "${FILESDIR}"/rm_valijson.patch

	eapply_user

	cmake_src_prepare
}
