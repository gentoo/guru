# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SEC_KEYS_VALIDPGPKEYS=(
	"35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3:artifact-registry-repository-signer:manual"
)

inherit sec-keys

DESCRIPTION="Google Cloud Artifact Registry Automatic Signing Key"
HOMEPAGE="https://docs.cloud.google.com/artifact-registry/docs"
SRC_URI="https://packages.cloud.google.com/apt/doc/apt-key.gpg -> ${P}.asc"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
