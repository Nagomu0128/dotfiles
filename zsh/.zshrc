# --- ランタイム ---
eval "$(mise activate zsh)"

# --- プロンプト ---
eval "$(starship init zsh)"

# --- 補完・ハイライト ---
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- 履歴 ---
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS SHARE_HISTORY

# --- エイリアス ---
alias ll='ls -la'
alias g='git'

# --- ghq × ripgrep 横断検索 (WezTerm Cmd+G から呼ばれる) ---
function ghq-grep() {
  local ghq_root
  ghq_root=$(ghq root) || return 1

  local rg_prefix="rg --column --line-number --no-heading --color=always --smart-case "
  local selected
  selected=$(
    : | fzf --ansi --disabled --query "" \
        --bind "start:reload:$rg_prefix {q} $ghq_root" \
        --bind "change:reload:sleep 0.1; $rg_prefix {q} $ghq_root || true" \
        --delimiter : \
        --preview 'bat --style=numbers --color=always --highlight-line {2} {1} 2>/dev/null || cat {1}' \
        --preview-window 'right:60%:+{2}-/2'
  )

  [ -z "$selected" ] && return 0

  local file line
  file=$(cut -d: -f1 <<< "$selected")
  line=$(cut -d: -f2 <<< "$selected")
  nvim "+$line" "$file"
}

# --- ローカル設定（Git 管理しない） ---
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# --- コメントアウトの有効化 ---
setopt INTERACTIVE_COMMENTS
export PATH="$HOME/.local/bin:$PATH"
