# Plugin

1. things 응용 내의 컴포넌트/컨테이너들은 플러그인의 구조를 가져야 한다.
1. things에서 플러그 인이란, 외부 생태계를 지원하기 위해 특정한 구조 명세를 따르도록한 구조적인 장치이며, things 컴포넌트들은 모두 구조 명세를 준수하여야 한다.
1. things 플러그인은 사용되기 전에 컴포넌트 레지스트리에 등록되어야 한다.
1. 종속성 관리 : 플러그인 구조 명세내의 dependency 에 종속 사용되는 플러그인 타입과 구현 객체의 매핑 정의를 해줄 수 있다.

## 레지스트리 등록 방법.
### 직접 등록
### dependency 명세에 의한 자동 등록
