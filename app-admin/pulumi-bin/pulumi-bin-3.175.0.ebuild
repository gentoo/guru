# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

DESCRIPTION="Infrastructure as code in any programming language"
HOMEPAGE="
	https://www.pulumi.com/
	https://github.com/pulumi/pulumi
"
SRC_URI="
	amd64? ( https://github.com/pulumi/pulumi/releases/download/v${PV}/pulumi-v${PV}-linux-x64.tar.gz )
	arm64? ( https://github.com/pulumi/pulumi/releases/download/v${PV}/pulumi-v${PV}-linux-arm64.tar.gz )
"

S="${WORKDIR}/pulumi"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# This is written in golang; rename to pulumi-bin and build this properly.
QA_PREBUILT="*"

src_install() {
	dobin pulumi*

	./pulumi gen-completion bash > pulumi.bash-completion || die "Cannot generate bash completions"
	newbashcomp pulumi.bash-completion pulumi

	./pulumi gen-completion zsh > pulumi.zsh-completion || die "Cannot generate zsh completions"
	newzshcomp pulumi.zsh-completion _pulumi
}
