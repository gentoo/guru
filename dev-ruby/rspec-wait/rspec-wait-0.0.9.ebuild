# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUBY_FAKEGEM_EXTRADOC=""
RUBY_FAKEGEM_GEMSPEC="rspec-wait.gemspec"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
USE_RUBY="ruby31 ruby32"

inherit ruby-fakegem

DESCRIPTION="enables time-resilient expectations in your RSpec test suite"
HOMEPAGE="https://github.com/laserlemon/rspec-wait"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend "
	>=dev-ruby/rspec-3
"
