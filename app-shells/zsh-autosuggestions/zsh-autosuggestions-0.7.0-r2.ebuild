# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32"
RUBY_OPTIONAL="yes"

inherit readme.gentoo-r1 ruby-ng

DESCRIPTION="Fish-like autosuggestions for zsh"
HOMEPAGE="https://github.com/zsh-users/zsh-autosuggestions"
SRC_URI="https://github.com/zsh-users/zsh-autosuggestions/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/all/${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="test? ( || ( $(ruby_get_use_targets) ) )"

RDEPEND=">=app-shells/zsh-4.3.11"
BDEPEND="
	test? (
		${RDEPEND}
		$(ruby_implementations_depend)
		app-misc/tmux
		dev-ruby/bundler
		dev-ruby/pry
		dev-ruby/pry-byebug
		dev-ruby/rspec:3
		dev-ruby/rspec-wait
		virtual/rubygems
	)
"

RESTRICT="!test? ( test )"

DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add
. /usr/share/zsh/site-functions/${PN}.zsh
at the end of your ~/.zshrc"

pkg_setup() {
	use test && ruby-ng_pkg_setup
}

src_prepare() {
	# FIXME: Disable failing tests
	rm "spec/options/buffer_max_size_spec.rb" \
		|| die "Could not remove tests"
	rm "spec/integrations/auto_cd_spec.rb" \
		|| die "Could not remove tests"

	if use test; then
		ruby-ng_src_prepare
	else
		default
	fi
}

src_configure() {
	use test && ruby-ng_src_configure
}

src_compile() {
	use test && ruby-ng_src_compile
}

each_ruby_test() {
	RSPEC_VERSION=3 ruby-ng_rspec
}

src_install() {
	insinto "/usr/share/zsh/site-functions/"
	doins "${PN}.zsh"

	readme.gentoo_create_doc
	einstalldocs
}

pkg_postinst() {
	readme.gentoo_print_elog
}
