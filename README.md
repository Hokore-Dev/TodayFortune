# 오늘의 운세 · Today's Fortune for Apple Watch

심플한 오늘의 운세 앱이 없어서 직접 만든 **Apple Watch용 운세 앱**입니다. (Swift / WatchKit)

<img src="/preview.jpg" width="360" alt="Today's Fortune on Apple Watch">

## ✨ 특징

- ⌚️ Apple Watch 네이티브 (WatchKit Extension)
- 📅 하루 한 번, 오늘의 운세 표시
- 🪶 군더더기 없는 단순한 UI

## 🔧 동작 방식

운세 데이터는 외부 웹 API에 `GET` 요청으로 받아옵니다.
소스의 GET 부분만 바꾸면 다른 API로 교체해 사용할 수 있어요.

- `TodayFortune/ViewController.swift`
- `TodayFortune WatchKit Extension/InterfaceController.swift`

---

> ⚠️ 오래전에 만든 개인 프로젝트입니다. 운세 날짜가 개발자 생일로 하드코딩돼 있고,
> 기존 API(`erumyasp.azurewebsites.net`)는 현재 동작하지 않을 수 있습니다.
