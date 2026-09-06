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

# --- ローカル設定（Git 管理しない） ---
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# --- コメントアウトの有効化 ---
setopt INTERACTIVE_COMMENTS
export PATH="$HOME/.local/bin:$PATH"
