# Event Bubbling

1. Event는 Component / Container로 구성된 모델 셋의 어떤 Component도 Event Triggering의 Target이 될 수 있다.
```
component.trigger (‘event type’, [event parameters], ..)
```
1. 일단 Trigger된 Event는 Event가 Target의 조상 Container들에게 순차적으로 전달된다.(Bubbling)
이 과정은 Root Container까지 계속된다.
1. Event Target으로부터 Root까지의 과정 중 어떤 Component/Container에서도 Event를 Subscribe해서 소비할 수 있다.

# Event 구성
## Event 구성하는 5가지 요소.
1. Event : Event 구조에서 전달되는 사건의 내용을 담고 있는 Object. Event Type으로 정의되는 Event 종류를 의미한다.
1. Event Target : 최초 Event가 발생한 Component를 의미한다.
1. Event Listener : Event Bubbling 과정 중에서 관심있는 Event를 Subscribe하는 Object 또는 Component이다.
1. Event Deligator : Event Bubbling 과정 중에서 Event Listener가 Event를 Subscribe하는 대상 Component이다.
1. Event Handler : 관심 Event를 처리하는 Logic

# Event Handling 구조
## Event를 구성하는 5가지 요소를 이해하면, Event Handling에 대한 구성을 간편하게 할 수 있다.
```
{
     Event Deligator :  {
          Event Target : {
               Event Type : function Event Handler( Event ) {
                    // this, 즉 function의 context는 Event Listener이다.
               }
          }
     }
}
```