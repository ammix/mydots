{
  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[[󰘧](sapphire) ❯](peach)";
        error_symbol = "[[󰘧](bold red) ❯](peach)";
        # success_symbol = "[󰘧](sapphire)";
        # error_symbol = "[󰘧](bold red)";
        vimcmd_symbol = "[[󰘧](sapphire) ❮](teal)";
        vimcmd_replace_symbol = "[[󰘧](sapphire) ❮](bold red)";
        vimcmd_replace_one_symbol = "[[󰘧](sapphire) ❮](bold maroon)";
        vimcmd_visual_symbol = "[[󰘧](sapphire) ❮](bold yellow)";
      };

      git_branch = {
        style = "bold mauve";
        disabled = true;
      };

      directory = {
        truncation_length = 4;
        truncate_to_repo = true;
        style = "bold lavender";
      };

      custom.jj = {
        ignore_timeout = true;
        description = "The current jj status";
        detect_folders = [ ".jj" ];
        symbol = "🥋 ";
        command = ''
          jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template '  separate(" ",    change_id.shortest(4),    bookmarks,    "|",    concat(      if(conflict, "💥"),      if(divergent, "🚧"),      if(hidden, "👻"),      if(immutable, "🔒"),    ),    raw_escape_sequence("\x1b[1;32m") ++ if(empty, "(empty)"),    raw_escape_sequence("\x1b[1;32m") ++ coalesce(      truncate_end(29, description.first_line(), "…"),      "(no description set)",    ) ++ raw_escape_sequence("\x1b[0m"),  )'
        '';
      };

      git_state.disabled = true;
      git_commit.disabled = true;
      git_metrics.disabled = true;

      # re-enable git_branch as long as we're not in a jj repo
      custom.git_branch = {
        when = true;
        command = "jj root >/dev/null 2>&1 || starship module git_branch";
        description = "Only show git_branch if we're not in a jj repo";
      };
    };
  };
}
