# atcoder-py

AtCoder を Python で解くための作業リポジトリ。
AtCoder のジャッジ環境に入っている主要ライブラリを uv で揃え、
サンプルテスト（`t`）と提出（`s`）を短いコマンドで行えるようにしている。

## 環境

| 項目 | バージョン / 内容 |
|---|---|
| Python | 3.13.7（`.python-version`、`requires-python >= 3.12`） |
| パッケージ管理 | [uv](https://docs.astral.sh/uv/) |
| テスト | [online-judge-tools](https://github.com/online-judge-tools/oj)（`oj`） |
| 提出・問題取得 | [atcoder-cli](https://github.com/Tatamo/atcoder-cli)（`acc`） |

### 主な依存ライブラリ

`ac-library-python`, `numpy`, `scipy`, `networkx`, `sortedcontainers`, `more-itertools`,
`sympy`, `gmpy2`, `mpmath`, `numba`, `bitarray`, `pandas`, `scikit-learn`, `pulp`, `shapely`

### セットアップ

```bash
# ツールのインストール
uv tool install online-judge-tools   # oj
npm install -g atcoder-cli           # acc
uv tool install aclogin              # ログイン用

# 依存ライブラリ（.venv を作成）
uv sync

# ログイン（oj / acc 両方にクッキーを保存）
aclogin
```

#### ログイン（aclogin）

`oj login` / `acc login` は AtCoder の CAPTCHA で通らないため、
ブラウザのクッキーを [aclogin](https://github.com/key-moon/aclogin) で各ツールに渡す。

1. ブラウザで AtCoder にログインする
2. 開発者ツールのクッキー一覧（Chrome なら Application → Cookies → `https://atcoder.jp`）から
   `REVEL_SESSION` の値をコピーする
3. `aclogin` を実行し、聞かれたら値を貼り付ける

oj と acc は自動で検出される。片方だけ更新したいときは `aclogin --tools oj` のように指定する。
ログインが切れたら同じ手順をやり直す。

## スクリプト

`scripts/` にある 2 つのスクリプトを使う。

### 対象の決まり方

どちらも引数を 1 つ取る（省略可）。

| 引数 | 対象の問題ディレクトリ |
|---|---|
| なし | カレントディレクトリ |
| `path/to/main.py` | そのファイルがあるディレクトリ |
| `path/to/問題dir` | そのディレクトリ |

問題ディレクトリに `main.py` がないとエラーで終了する。

### `t` — サンプルケースでテスト

```bash
t                    # カレントの main.py をテスト
t abc400/a           # ディレクトリ指定
t abc400/a/main.py   # ファイル指定
```

問題ディレクトリで次を実行する。

```bash
oj t -c "<repo>/.venv/bin/python main.py" -d ./tests/
```

- 問題ディレクトリの `tests/` にあるサンプル入出力で判定する
- リポジトリの `.venv` の Python を使うので、venv を有効化しなくてよい

### `s` — 提出

```bash
s                    # カレントの main.py を提出
s abc400/a
```

問題ディレクトリで `acc s main.py` を実行する。
提出先の問題は、`acc new` で作ったディレクトリの設定から acc が判断する。

### PATH の設定

`s` / `t` だけで呼ぶには `scripts/` を PATH に追加する。

```bash
# 例: ~/.zshrc
export PATH="$HOME/ghq/github.com/ki-mutaku/atcoder-py/scripts:$PATH"
```

PATH に追加しない場合は `./scripts/t` のようにパスを付けて実行する。
