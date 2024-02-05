git_branch() {
	git rev-parse HEAD >/dev/null 2>&1 || return
	git branch --color=always --all --sort=-committerdate |
		grep -v HEAD |
		fzf --height 50% --ansi --no-multi --preview-window right:65% \
			--preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
		sed "s/.* //"
}

git_checkout() {
	git rev-parse HEAD >/dev/null 2>&1 || return
	local branch
	branch=$(git_branch)
	if [[ "$branch" = "" ]]; then
		echo "No branch selected."
		return
	fi
	# If branch name starts with 'remotes/' then it is a remote branch. By
	# using --track and a remote branch name, it is the same as:
	# git checkout -b branchName --track origin/branchName
	if [[ "$branch" = 'remotes/'* ]]; then
		git checkout --track $branch
	else
		git checkout $branch
	fi
}
