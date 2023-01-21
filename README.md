# 현재 오류발생으로 한줄씩 직접입력해야함.. ㅠ

## 실행 방법

```bash
sudo su
sudo curl -o- https://raw.githubusercontent.com/panta5/EasyOracleCloud/main/start.sh
```

## 관리 방법

웹에서 접근할 수 있는 파일은 /var/www/html 폴더임.

거기다가 파일 집어넣고

```bash
sudo chown -R root:root /var/www/html
```

해주면 파일 정상적으로 이용할수있음 (파일 소유권때문에 오류날수도 있어서 파일 집어넣을때마다 해주는게 좋음.)

그리고, https 인증서를 3개월마다 갱신해줘야 하는데 한달에 한 번 정도

```bash
sudo certbot renew
sudo systemctl restart nginx
```

실행해주셈.
