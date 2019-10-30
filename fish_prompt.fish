function fish_prompt
  # Setup colors
  set -l normal (set_color normal)
  set -l white (set_color white)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l cyan (set_color cyan)
  set -l magenta (set_color magenta)
  set -l red (set_color red)
  set -l bold (set_color -o)

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    if test -e ~/.box-name
      set -g __fish_prompt_hostname (cat ~/.box-name)
    else
      set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end
  end

  if not set -q __fish_prompt_char
    switch (id -u)
      case 0
	     set -g __fish_prompt_char $magenta'#'
      case '*'
	     set -g __fish_prompt_char $cyan'$'
    end
  end
 
  # Configure __fish_git_prompt
  set -g __fish_git_prompt_char_stateseparator ' '
  set -g __fish_git_prompt_color brcyan
  set -g __fish_git_prompt_color_flags df5f00
  set -g __fish_git_prompt_color_prefix white
  set -g __fish_git_prompt_color_suffix white
  set -g __fish_git_prompt_showdirtystate true
  set -g __fish_git_prompt_showuntrackedfiles true
  set -g __fish_git_prompt_showstashstate true
  set -g __fish_git_prompt_show_informative_status true
 
  # Env
  set -l last_status $status
  set -l __work_dir (string replace $HOME '~' (pwd))

  # Time
  set -l __time $white'['(date +%H:%M:%S)']'

  # Line
  echo -sne '\n& '$blue$USER$white \
    '@'$green$__fish_prompt_hostname$normal \
    ' '$bold$__work_dir$normal \
    (__fish_git_prompt) \
    ' '$__time \
    '\n'$__fish_prompt_char$normal \
    ' ';
end
