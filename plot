import requests
from bs4 import BeautifulSoup
import csv

# CSV 파일에 저장하기 위한 헤더 정보 설정
headers = ['Name', 'Address', 'Phone']

# CSV 파일 열기
with open('yeogie_directory.csv', 'w', encoding='utf-8', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(headers)

    # 내부 페이지를 순환하며 데이터 크롤링
    for i in range(1, 2129):
        url = f'https://yeogie.com/directory/?page={i}'
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')

        # 데이터 추출
        for listing in soup.find_all('div', class_='listing'):
            name = listing.find('h2', class_='title').text.strip()
            address = listing.find('div', class_='address').text.strip()
            phone = listing.find('div', class_='phone').text.strip()

            # CSV 파일에 데이터 저장
            writer.writerow([name, address, phone])
