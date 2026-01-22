$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.config.edit_mode = "vi"

$env.config.completions.external = {
  enable: true
  max_results: 100
  completer: {|spans|
    fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
    | from tsv --flexible --noheaders --no-infer
    | rename value description
    | update value {|row|
      let value = $row.value
      let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
      if ($need_quote and ($value | path exists)) {
        let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
        $'"($expanded_path | str replace --all "\"" "\\\"")"'
      } else {$value}
    }
  }
}

alias rm = rm -Iv
alias rmr = rm -vrf

alias l = eza -al
alias ll = eza -l

# Flatpak
alias fu = flatpak uninstall --delete-data

# Git
alias ga = git add
alias gaa = git add --all
alias gc = git commit
alias gcm = git commit -m
alias gst = git status
alias gp = git push
alias gpl = git pull
alias gd = git diff
alias gra = git remote add
alias gcl = git clone

# Jujutsu
alias jjgc = jj git clone --colocate
alias jjcm = jj commit -m
alias jji = jj git init --colocate
alias jjf = jj git fetch --all-remotes
alias jjr = jj remote add
alias jjb = jj bookmark set

def jjbp [] {
  jj bookmark set main -r@-
  jj git push
}

def extract [file: string] {
  let ext = ($file | path parse | get extension)
  let stem = ($file | path parse | get stem)

  match $ext {
    "tar" | "gz" | "tgz" | "bz2" | "tbz2" | "xz" | "txz" | "zst" | "tzst" => {
      if ($file | str ends-with ".tar.gz") or ($file | str ends-with ".tar.bz2") or ($file | str ends-with ".tar.xz") or ($file | str ends-with ".tar.zst") {
        tar -xvf $file
      } else if $ext == "tar" {
        tar -xvf $file
      } else if $ext == "gz" {
        gunzip $file
      } else if $ext == "bz2" {
        bunzip2 $file
      }
    }
    "zip" | "7z" | "rar" | "jar" | "war" | "ear" => {
      let dirname = $stem
      7z x $file $"-o($dirname)"
    }
    _ => {
      print $"Cannot extract '($file)': Unknown format."
      return 1
    }
  }
}

def fbackup [file: string] {
  cp $file $"($file).bak"
}

def --env dev [] {
  let selected = (
    ls ~/dev
    | where type == dir
    | get name
    | to text
    | fzf
    | str trim
  )

  if ($selected | is-not-empty) {
    cd $selected
    nvim
  }
}

$env.config.keybindings = ($env.config.keybindings | append {
  name: "dev_fzf_launcher"
  modifier: control
  keycode: char_f
  mode: [emacs, vi_normal, vi_insert]
  event: {
    send: executehostcommand
    cmd: "dev"
  }
})

def sysclean [] {
  nix-collect-garbage -d
  flatpak uninstall --unused --assumeyes
}

def sysup [] {
  nix flake update --flake ~/mydots/nix
  nh home switch ~/mydots/nix/
  podman update searxng
  flatpak update
}
