# 동작 시키기
## 컴포넌트 선택하기
Stage의 select 메쏘드를 사용해서 원하는 컴포넌트를 찾아낸다.
```
var image = stage.select('image')[0]; // 첫번째 이미지를 찾는다.
```
select 메쏘드는 파라미터로 selector를 받을 수 있다.
select 메쏘드는 주어진 selector로 해당하는 컴포넌트의 배열을 리턴한다.
selector 종류와 표현법은 API-Reference를 참조한다.
## 컴포넌트 변경하기
컴포넌트를 찾았으며, 각 컴포넌트의 get/set 메쏘드로 현재의 속성값을 조회하고, 변경할 수 있다.
```
var x = image.get('x');
var y = image.get('y');
image.set('fillStyle', 'lightgray'); // 한가지 속성값을 변경
image.set({
  strokeStyle: 'blue',
  lineWidth: 6,
    x: x + 10
    y: y + 10
}); // 여러가지 설정값을 동시에 변경
```

selector를 이용해서 컴포넌트의 속성을 변경하는 또 다른 방법이 있다.
Stage의 apply 메쏘드를 사용해서, Stage 내부에 가지고 있는 컴포넌트들의 셀렉터를 키로하고 속성오브젝트를 밸류로 하는 세트(오브젝트)로 한꺼번에 변경할 수 있다.
```
stage.apply({
  'line': {
      'lineWidth': 100,
        'x1': 100,
        'y1': 100
    },
    '.vruler': {
      'strokeStyle': 'red'
    }
});
```
이 샘플 코드를 보면, Stage가 가지고 있는 모든 line 컴포넌트의 폭과, x1, y1 값을 동시에 변경하며, 'vruler' 라고 태깅되어있는 컴포넌트의 'strokeStyle'을 변경한다.
## 컴포넌트 추가하기
## 컴포넌트 제거하기
