[@zokugun/lang.math.matrix](https://github.com/ZokugunKS/lang.math.matrix)
==============================================================

[![kaoscript](https://img.shields.io/badge/language-kaoscript-orange.svg)](https://github.com/kaoscript/kaoscript)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)
[![NPM Version](https://img.shields.io/npm/v/@zokugun/lang.math.matrix.svg?colorB=green)](https://www.npmjs.com/package/@zokugun/lang.math.matrix)
[![Dependency Status](https://badges.depfu.com/badges//overview.svg)](https://depfu.com/github/zokugun/lang.math.matrix)
[![Build Status](https://travis-ci.org/ZokugunKS/lang.math.matrix.svg?branch=master)](https://travis-ci.org/ZokugunKS/lang.math.matrix)
[![CircleCI](https://circleci.com/gh/ZokugunKS/lang.math.matrix/tree/master.svg?style=shield)](https://circleci.com/gh/ZokugunKS/lang.math.matrix/tree/master)
[![Coverage Status](https://img.shields.io/coveralls/ZokugunKS/lang.math.matrix/master.svg)](https://coveralls.io/github/ZokugunKS/lang.math.matrix)

Provides matrix functions.

Getting Started
---------------

With [node](http://nodejs.org) previously installed:

	npm install @zokugun/lang.math.matrix

Use it with `JavaScript`:

```javascript
require('kaoscript/register');

const { Matrix } = require('@zokugun/lang.math.matrix')();

const m = Matrix.multiply(
	[
		[0, 1, 2],
		[3, 4, 5]
	],
	[
		[0, 3],
		[1, 4],
		[2, 5]
	]
);
```

Use it with `kaoscript`:
```kaoscript
import '@zokugun/lang.math.matrix'

const m = Matrix.multiply(
	[
		[0, 1, 2],
		[3, 4, 5]
	],
	[
		[0, 3],
		[1, 4],
		[2, 5]
	]
)
```

License
-------

[MIT](http://www.opensource.org/licenses/mit-license.php) &copy; Baptiste Augrain
