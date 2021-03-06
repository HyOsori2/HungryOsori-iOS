# HungryOsori-iOS
HungryOsori는 웹 크롤링 기반 Push 서비스입니다. 웹에서 컨텐츠가 변하면, 스마트폰 Push로 알려주며, 이 어플은 Swift를 이용하여 만든 아이폰 어플입니다.

## OverView
* 자신이 원하는 크롤러를 구독하면, 서버로부터 자신이 구독한 크롤러의 변동사항 등이 있을 시, 푸쉬서버로부터, 알람이 온다.
* 해당 크롤러를 눌렀을 경우, 웹 뷰를 통하여, 해당 크롤링한 사이트를 보여줌.

## Crawler
* 전체 크롤러 리스트 : https://github.com/HyOsori/Osori-WebCrawler 참고

## Server
* API-Server : 앱에 사용자 등록 등 앱(iOS, Android)과 관련된 통신은 이곳에서 관리.
* API-Server 관련 문서 :        https://github.com/HyOsori/HungryOsori-Server/tree/master/crawlerAPI


* Push-Server : HyOsori/Osori-WebCrawler(https://github.com/HyOsori/Osori-WebCrawler) 에 있는 크롤러 파일들 주기적 크롤링하며, 변경사항 체크후 Android/iOS 어플에 푸시 알람
* Push-Server 관련 문서 : https://github.com/HyOsori/HungryOsori-PushServer


## Install
```
git clone https://github.com/HyOsori/HungryOsori-iOS.git
```

## Architecture
![Alt text](/Architecture.png?raw=true)

## Implementation
* [Protected View] : 로그인 이전 로딩 페이지. 이전에 로그인한 기록이 있을 경우, 로그인 창으로 이동 없이, 전체 리스트로 이동.

* [Login View] : 로그인 페이지. 이메일과 비밀번호 입력란과, 로그인, 회원가입, 비밀번호 찾기로 구성됨

* [Register View] : 회원가입 페이지. 아이디를 이메일인지 정규식으로 체크, 비밀번호 체크를 한 뒤, 가입함

* [전체리스트 View] : Push 서버로부터 크롤링한 데이터를 TableView를 이용하여 보여주는 View

* [구독리스트 View] : 전체리스트에서 구독한 크롤러들을 띄어주는 View

* [User Information View] : 유저 ID와 PWD를 보여주며, 비밀번호 변경 버튼 존재함

* [PWD Change View] : 비밀번호 변경하는 페이지. 아이디, 기존 비밀번호와 신규 비밀번호 입력시 변경.

* [FindPWD View] : 아이디를 입력하면, 새로운 비밀번호를 알려주는 페이지

* [WebView] : 선택한 크롤러에 해당하는, 웹페이지를 보여주는 페이지

## 사용한 OpenSource Library
* [Alamofire](https://github.com/Alamofire/Alamofire) : HTTP 네트워킹 라이브러리
* [SDWebImage](https://github.com/rs/SDWebImage) : 웹의 이미지(URL 등)를 불러오는 라이브러리
* [FireBase](https://firebase.google.com/?hl=ko) : FCM을 이용하기 위하여, 사용한 Google FireBase 라이브러리

## Contributors
* [kanak87](https://github.com/kanak87)
* [seubseub](https://github.com/seubseub)

```
The MIT License (MIT)

Copyright (c) 2016 Hanyang Osori

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
