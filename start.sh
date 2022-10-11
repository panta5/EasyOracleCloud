#!/bin/bash

# 사이트 URL 사용자로부터 받기
sudo echo -n "프로토콜 및 파라미터를 제외한 사이트 URL을 입력하세요(ex. naver.com): "
sudo read SITE_URL
sudo echo "$SITE_URL 을 입력하셨습니다. 이어서 진행합니다."

# 패키지 목록 업데이트 및 업그레이드
sudo apt update && sudo apt upgrade -y

# Nginx 설치
sudo apt install nginx

# Certbot 설치
sudo snap install --classic certbot

# dhparam 생성
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# Certbot /usr/bin 에 등록
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# Nginx config 파일 경로 링크 생성
sudo ln -s /etc/nginx/sites-enabled /sites

# IP주소로 직접 접근 차단
sudo rm /sites/default
sudo wget https://raw.githubusercontent.com/panta5/EasyOracleCloud/main/default -O /sites/default

# Nginx config 파일 받아오기
sudo wget https://raw.githubusercontent.com/panta5/EasyOracleCloud/main/before.conf -O /sites/before.conf

# URL에 맞게 수정
sudo sed -i "s/{SITE_URL}/$SITE_URL/g" /sites/before.conf

# 수정된 Config 적용
sudo systemctl restart nginx

# https 인증서 발급
sudo certbot certonly --nginx -d "$SITE_URL"

# 새로운 Nginx config 파일 받아오기
sudo wget https://raw.githubusercontent.com/panta5/EasyOracleCloud/main/after.conf -O /sites/after.conf

# 기존 config 삭제
sudo rm /sites/before.conf

# URL에 맞게 수정
sudo sed -i "s/{SITE_URL}/$SITE_URL/g" /sites/after.conf

# web 폴더 권한 지정
sudo chown -R www-data:www-data /var/www/html

# Nginx 재시작
sudo systemctl restart nginx
