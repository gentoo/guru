# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUBY_FAKEGEM_EXTRADOC=""
RUBY_FAKEGEM_GEMSPEC=""
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
USE_RUBY="ruby31 ruby32"

inherit ruby-fakegem

DESCRIPTION="Step-by-step debugging and stack navigation in Pry"
HOMEPAGE="https://github.com/deivid-rodriguez/pry-byebug"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend "
	>=dev-ruby/byebug-11.0
	>=dev-ruby/pry-0.13
	<dev-ruby/pry-0.15
"
