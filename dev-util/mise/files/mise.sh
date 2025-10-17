if [ -n "$ZSH_NAME" ]; then
	if (( ${+commands[mise]} )); then
		# shellcheck disable=SC1090
		source <(mise activate zsh) || true
	fi
elif [ -n "$BASH_VERSION" ]; then
	if command -v mise >/dev/null 2>&1; then
		eval "$(mise activate bash)" || true
	fi
fi
