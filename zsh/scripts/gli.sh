gli() {
	if [[ ! $(git log -n 1 $@ | head -n 1) ]]; then
		return
	fi
	local filter
	if [ -n $@ ] && [ -f $@ ]; then
		filter="-- $@"
	fi
	local gitlog=(
		git log
		--graph --color=always
		--abbrev=7
		--format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr'
		$@
	)
	local fzf=(
		fzf
		--ansi --no-sort --reverse --tiebreak=index
		--preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}"
		--bind "ctrl-q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % $filter | less -R') << 'FZF-EOF'
                {}
                FZF-EOF"
		--preview-window=right:60%
	)
	$gitlog | $fzf
}
