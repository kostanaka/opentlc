# opentlc
These playbooks may be useful to customize/update OpenTLC lab environment (Only "CF4.1 customization" is supposed so far).
You have to prepare your ssh key file which is registered on opentlc web site.
see. http://www.opentlc.com/ssh.html

## 準備

1. OpenTLCにログインする https://labs.opentlc.com/
2. Catalogにある"CloudForms 4.1 Customization Lab"をorderし、環境構築が完了するまで待つ

### ローカルでAnsibleが使える人：

3. workstation-${GUID}.rhpds.opentlc.com へidentityファイル指定せずにsshできるよう設定しておいて下さい。以下は ~/.ssh/configの例
```
Host workstation-*.rhpds.opentlc.com
  IdentityFile ~/.ssh/id_rsa_nopass
  User myname-redhat.com
```

4. 適当な場所へplaybookをダウンロードして、実行
```
cd /tmp
wget https://raw.githubusercontent.com/kostanaka/opentlc/master/prov-workstation.yml
ansible-playbook -i workstation-${GUID}.rhpds.opentlc.com, prov-workstation.yml
```

### ローカルでAnsibleが使えない人：

3. OpenTLCへ登録しているidentityファイルにて、workstation-${GUID}.rhpds.opentlc.comへログインします
4. rootになり、/root へ行きます
5. EPELを有効にします
6. 必要なパッケージを入れます
7. playbook他をダウンロードします
```
ssh -i /your/identity/file yourname-redhat.com@workstation-${GUID}.rhpds.opentlc.com
sudo -i
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y git expect ansible
git clone https://github.com/kostanaka/opentlc.git
```

## Ansible Towerのバージョンアップ

バージョンアップつーか、既存のものを消して新しいものをインストールします。
[村井さんが作ったガイド](https://github.com/mamurai/docs/blob/master/01_Ascii_Doc/30_Ansible-Tower/AnsibleTower-vCenter_Demo.adoc)もあるので、参考にして下さい：

1. workstation-${GUID}.rhpds.opentlc.com へログインし、rootになります
2. /root/opentlc ディレクトリへ移動します
3. プレイブック: update-ansible.yml を実行します
```
ssh workstation-${GUID}.rhpds.opentlc.com
sudo -i
cd opentlc
ansible-playbook -i inventory update-ansible.yml
```

adminユーザーのパスワードは"password"でインストールされます。嫌な方はinventoryにある変数を変更した上で実行して下さい。

## CloudFormsのバージョンアップ

既存のCFは4.1なので、これを4.2へバージョンアップします。
既に workstation-${GUID}でrootになっているものとします(@/root/opentlc)

1. プレイブック: update-cf-1.yml を実行します
2. プレイブック: update-cf-2.yml を実行します
```
ansible-playbook -i inventory update-cf-1.yml
ansible-playbook -i inventory update-cf-2.yml
```
パスワードは従来通り変更ありません。

以上

## 忘備録(その他やるべき事)

以下は手作業ですが、やっとかないとハマるので書いておきます::

1. CloudFormsで、ロールを追加しておく
