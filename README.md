<img alt="toonie_app_store_logo.png" src="https://github.com/yapp-project/Toonie/blob/develop/image/toonie_app_store_logo.png" style="max-width: 50%">

<p align="center">
  <img alt="Swift" src="https://img.shields.io/badge/swift-4.2-orange.svg">
  <img alt="Platform" src="https://img.shields.io/badge/platform-ios-lightgrey.svg">
  <a href="https://travis-ci.org/boostcamp3-iOS/team-c2" target="_blank">
    <img alt="Build Status" src="https://travis-ci.org/yapp-project/Toonie.svg?branch=master">
  </a>

# Toonie


## 팀원 정보

**iOS 클라이언트** :  [박은비](https://github.com/ebPark9511) [양어진](https://github.com/eojine) [이재은](https://github.com/Jae-eun)

**서버** :  [조경현](https://github.com/EddyJo)



## 앱 소개

### 키워드를 통한 인스타툰 추천 서비스

- .



# #

![이미지](./image/X_01.png)![이미지](./image/X_02.png)

![이미지](./image/X_03.png)![이미지](./image/X_04.png)![이미지](./image/X_05.png)



## 버전 정보 

> version 1.0



## 앱 스토어

<a href="https://itunes.apple.com/kr/app/"> <img src="" width="170" height="58"></a>

## 

### 활용 기술

- **[SwiftLint](https://github.com/realm/SwiftLint)** 적용

```yaml
# .swiftlint.yml
disabled_rules:
- leading_whitespace
- trailing_whitespace

opt_in_rules:

included:

line_length:
warning: 99
error: 120

excluded:
- Toonie/Supporting Files/AppDelegate.swift
- Pods
```

- `project.pbxproj` 파일의 충돌을 최소화하고 해결을 쉽게 하기 위해 **[xUnique](https://github.com/truebit/xUnique)** 사용

- 