# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/cpuguy83/go-md2man/v2 v2.0.5"
	"github.com/cpuguy83/go-md2man/v2 v2.0.5/go.mod"
	"github.com/creack/pty v1.1.9"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/gofrs/flock v0.12.1"
	"github.com/gofrs/flock v0.12.1/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/opencontainers/runtime-spec v1.2.1"
	"github.com/opencontainers/runtime-spec v1.2.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rogpeppe/go-internal v1.9.0"
	"github.com/rogpeppe/go-internal v1.9.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/stretchr/objx v0.5.2"
	"github.com/stretchr/objx v0.5.2/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"github.com/urfave/cli/v2 v2.27.6"
	"github.com/urfave/cli/v2 v2.27.6/go.mod"
	"github.com/xrash/smetrics v0.0.0-20240521201337-686a1a2994c1"
	"github.com/xrash/smetrics v0.0.0-20240521201337-686a1a2994c1/go.mod"
	"golang.org/x/mod v0.19.0"
	"golang.org/x/mod v0.19.0/go.mod"
	"golang.org/x/sys v0.22.0"
	"golang.org/x/sys v0.22.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	"tags.cncf.io/container-device-interface/specs-go v1.0.0"
	"tags.cncf.io/container-device-interface/specs-go v1.0.0/go.mod"
)

go-module_set_globals

DESCRIPTION="AMD container runtime toolkit"
HOMEPAGE="https://github.com/ROCm/container-toolkit"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ROCm/container-toolkit.git"
else
	SRC_URI="
		https://github.com/ROCm/container-toolkit/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${EGO_SUM_SRC_URI}
	"
	S="${WORKDIR}/container-toolkit-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0/${PV}"

# Tests may require specific environmental setups or additional hardware.
RESTRICT="test"

src_compile() {
	# Skip 'gen' and 'checks' targets which require network access
	# to download golangci-lint and goimports
	emake container-toolkit container-toolkit-ctk
}

src_install() {
	dobin bin/deb/amd-container-runtime \
		bin/deb/amd-ctk
}

pkg_postinst() {
	elog "Your docker or containerd (if applicable) service may need restart"
	elog "after install this package:"
	elog "OpenRC: rc-service containerd restart; rc-service docker restart"
	elog "systemd: systemctl restart containerd; systemctl restart docker"
	elog ""
	elog "To configure the AMD container runtime for Docker, run:"
	elog "  sudo amd-ctk runtime configure --runtime=docker"
	elog "  sudo systemctl restart docker"
	elog ""
	elog "For more details, see:"
	elog "  https://instinct.docs.amd.com/projects/container-toolkit/en/latest/"
}
