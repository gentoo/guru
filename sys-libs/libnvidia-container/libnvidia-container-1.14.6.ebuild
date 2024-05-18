# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# check the VERSION in libnvidia-container/mk/nvidia-modprobe.mk
NVMODV="550.54.14"

DESCRIPTION="NVIDIA container runtime library"
HOMEPAGE="https://github.com/NVIDIA/libnvidia-container"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/NVIDIA/${PN}.git"
else
	SRC_URI="
		https://github.com/NVIDIA/${PN}/archive/v${PV/_rc/-rc.}.tar.gz -> ${P}.tar.gz
		https://github.com/NVIDIA/nvidia-modprobe/archive/${NVMODV}.tar.gz -> ${PN}-nvidia-modprobe-${NVMODV}.tar.gz
	"
	S="${WORKDIR}/${PN}-${PV/_rc/-rc.}"
	NVMODS="${WORKDIR}/nvidia-modprobe-${NVMODV}"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0/${PV}"
IUSE="doc static-libs"

RDEPEND="
	net-libs/libtirpc:=
	sys-libs/libcap
	sys-libs/libseccomp
	virtual/libelf:=
	x11-drivers/nvidia-drivers
"

DEPEND="${RDEPEND}"

BDEPEND="
	dev-build/bmake
	dev-lang/go
	net-libs/rpcsvc-proto
	sys-apps/lsb-release
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.14.6-fix-makefile.patch
)

DOCS=( COPYING COPYING.LESSER LICENSE NOTICE README.md)

src_prepare() {
	# nvidia-modprobe patching based on libnvidia-container/mk/nvidia-modprobe.mk
	mkdir -p "${S}"/deps/src/nvidia-modprobe-"${NVMODV}" || die
	cp -r "${NVMODS}"/modprobe-utils/ "${S}"/deps/src/nvidia-modprobe-"${NVMODV}"/ || die
	touch "${S}/deps/src/nvidia-modprobe-${NVMODV}/.download_stamp" || die
	pushd "${S}/deps/src/nvidia-modprobe-${NVMODV}" || die
	eapply -p1 "${S}"/mk/nvidia-modprobe.patch
	popd || die

	default
}

src_compile() {
	export GOPATH="${S}"
	export GOFLAGS="-mod=vendor"
	IFS='_' read -r MY_LIB_VERSION MY_LIB_TAG <<< "${PV}"
	emake \
		CGO_CFLAGS="${CFLAGS}" \
		CGO_LDFLAGS="${LDFLAGS}" \
		GO_LDFLAGS="-compressdwarf=false -linkmode=external" \
		REVISION="${PV}" \
		LIB_VERSION="${MY_LIB_VERSION}" \
		LIB_TAG="${MY_LIB_TAG}"
}

src_install() {
	emake \
		CGO_CFLAGS="${CFLAGS}" \
		CGO_LDFLAGS="${LDFLAGS}" \
		GO_LDFLAGS="-compressdwarf=false -linkmode=external" \
		REVISION="${PV}" \
		LIB_VERSION="${MY_LIB_VERSION}" \
		LIB_TAG="${MY_LIB_TAG}" \
		DESTDIR="${D}" \
		install
	# Install docs
	if use doc ; then
		einstalldocs # Bug 831705
	fi
	# Cleanup static libraries
	if ! use static-libs ; then
		find "${ED}" -name '*.a' -delete || die # Bug 783984
	fi
}
