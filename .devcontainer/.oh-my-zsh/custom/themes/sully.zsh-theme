# Requires installing posh-git-sh [https://github.com/lyze/posh-git-sh#posh-git-bash]
local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$fg_bold[green]%}%n%{$reset_color%} %{$fg_bold[blue]%}%2~%{$reset_color%} $(__posh_git_echo)%{$reset_color%}%B»%b '
RPS1="${return_code}"
