# things Application 구조

Stage <=> Controller <= All Components
- Layer A
     - Component
     - Container
          - Component
          - Container
               - Component
               - Component
               - ..
- Layer B
- Layer C
- Layer ..

1. 최상위에 Stage 컴포넌트가 있다.
1. 차상위에는 Layer 컴포넌트로 구성된다.
1. Layer 아래에서는 컴포넌트 / 컨테이너들로 구성된다.

## Controller

1. things 응용의 전체적인 구성을 위한 역할을 한다.
1. 각 컴포넌트의 명세를 등록하고, 컴포넌트 인스턴스를 생성하여 전체 구조에 조인시킨다. (컴포넌트 레지스트리, 컴포넌트 팩토리)
1. 사용이 끝난 컴포넌트를 모델 구조에서 제거한다. (라이프 사이클 매니지먼트)
1. 이벤트 버블링을 위한 엔진이 포함된다. (이벤트 트래커, 펌프, 엔진)
1. 커맨드 패턴을 지원하는 엔진이 포함된다. (redo / undo)

## Stage

1. 전체 things 응용의 루트이다.
1. things 응용의 인스턴스이며, things 응용의 기능 API를 export하는 역할을 한다.
1. things 응용을 활용하는 외부에서는 Stage를 통해서 활용하게 된다.
1. things 응용의 루트를 담기위한 HTML div 엘리먼트를 Wrapping 한다.
1. 브라우저 내에서 things 객체를 담는 그릇을 만들고, 이벤트 구조를 위한 브라우저 사용자 이벤트(마우스, 탭)의 단일한 리스닝 포인트이며, 이벤트 버블링의 집합지점이다.

## Layer

1. 실질적인 그래픽 렌더링 기능을 위한 HTML canvas 오브젝트를 Wrapping 한다.
1. 캔바스는 실질적인 그래픽 기능을 위한 컨텍스트를 제공하는 역할을 하며,
사용자 이벤트의 타겟으로 이벤트 수집을 위한 이벤트 발생의 실질적인 시작점이 된다.
1. 대부분의 이벤트 핸들링 로직의 구현 장소이기도 하다.

## 컨테이너

1. 사각형 바운드 디멘션 속성(x, y, w, h)을 갖고 하위에 컴포넌트들을 가질 수 있는 그룹의 역할을 한다.
1. Stage와 Layer도 일종의 컨테이너이다. 대표적인 컨테이너 타입으로 Group이 있다.

## 컴포넌트

1. 최종 말단의 그래픽 객체를 의미한다.
1. 대부분의 그래픽 컴포넌트의 주요 기능이 구현되어있는 것들이다.
1. Circle, Rectangle, Line, TextBox, Image, Barcode, Chart 등이 여기에 속한다.