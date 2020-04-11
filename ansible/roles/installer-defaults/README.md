# installer-defaults role

インストーラのデフォルト設定を保持する role です。

また、オフラインインストール用に使用する yum リポジトリ設定を
`yum_enablerepo`, `yum_disablerepo` 変数に設定します。

* オンラインインストール時: デフォルトのまま
* オフラインインストール時: `kubernetes-offline` リポジトリ有効、他全リポジトリ無効