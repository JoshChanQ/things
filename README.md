things
======

Graphic Modeling Framework based on Javascript canvas.

## 'things' means ..
 * Things I love.
 * 모든 사물을 그 특징과 자료 구조대로 쉽고 잘 묘사할 수 있도록 표현 기능을 제공하고자 함
 * Things of the 'Internet of Things' 사물 ID 라벨링 및 모니터링 기능으로 모든 사물의 연결에 기여하고자 함

## Features
 * 기초 도형 모델링 및 표현
 * 확장 가능한 플러그인 구조
 * 모델링/모니터링 레이어
 * 이해하기 쉬운 이벤트 시스템
 * Redo/Undo 커맨드 패턴
 * JSON 형태 모델 구조

## 테스트해보기

```
$ npm install
$ bower install
$ grunt
```

## Getting Started
It supports packages for nodejs, bower & rails.

As a gem for rails provides:

  * things-rails

As a package for nodejs provides:

  * io-things

As a package for bower provides:

  * things (pending)

### Install the nodejs module with:
`npm install io-things --save`

### Install the bower module with:
`bower install things --save`

### Configure for requirejs as follow:

```js
requirejs.config({
	...
	paths: {
		'things'           : 'bower_components/things/dist/things'
	},
	shim: {
		things: {
			exports: 'things'
		}
	},
	...
});
```

### Install the rails module with Gemfile

```ruby
gem "things-rails"
```

And run `bundle install`. The rest of the installation depends on
whether the asset pipeline is being used.

### Rails 3.1 or greater (with asset pipeline *enabled*)

The dou-rails files will be added to the asset pipeline and available for you to use. If they're not already in `app/assets/javascripts/application.js` by default, add these lines:

```js
//= require things
```

## Usage


## License
Copyright (c) 2014 Hearty, Oh. Licensed under the MIT license.
