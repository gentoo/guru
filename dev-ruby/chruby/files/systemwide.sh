if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source /usr/share/chruby/chruby.sh

  # If you want chruby to auto-switch the `.ruby-version` of Ruby when you
  # cd between your different projects, uncomment following line:
  #source /usr/share/chruby/auto.sh
fi
