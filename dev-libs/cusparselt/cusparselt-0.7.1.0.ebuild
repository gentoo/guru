EAPI=8

DESCRIPTION="A High-Performance CUDA Library for Sparse Matrix-Matrix Multiplication"
HOMEPAGE="https://docs.nvidia.com/cuda/cusparselt/index.html"
SRC_URI="https://developer.download.nvidia.com/compute/cusparselt/redist/libcusparse_lt/linux-x86_64/libcusparse_lt-linux-x86_64-${PV}-archive.tar.xz"
S="${WORKDIR}/libcusparse_lt-linux-x86_64-${PV}-archive"

LICENSE="NVIDIA-SDK"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="=dev-util/nvidia-cuda-toolkit-12*"

QA_PREBUILT="/opt/cuda/targets/x86_64-linux/lib/*"

src_install() {
	insinto /opt/cuda/targets/x86_64-linux
	doins -r include lib
}
