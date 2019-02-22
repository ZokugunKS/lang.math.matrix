#![bin]

extern {
	describe:	func
	it:			func
	console
}

import {
	'chai' {
		* => chai
		expect
	}
	'..'
}

// fix error of -0 != +0
chai.use(func(chai, utils) { // {{{
	const Assertion = chai.Assertion
	const flag = utils.flag

	Assertion.addMethod('array', func(expected) {
		const array = flag(this, 'object')

		this.assert(
			array is Array
			'expected #{this} to be an array'
		)

		this.assert(
			array.length == expected.length
			'expected #{this} to have the same length'
		)

		for value, index in array {
			if value is Array {
				expect(value).to.array(expected[index])
			}
			else {
				expect(value).to.equal(expected[index])
			}
		}

		return this
	})
}) // }}}

describe('matrix', func() {
	it('adjugate 2x2', func() { // {{{
		expect(Matrix.adjugate([
			[0, 1],
			[1, 2]
		])).to.eql([
			[2, -1],
 			[-1, 0]
		])
	}) // }}}

	it('adjugate 3x3', func() { // {{{
		expect(Matrix.adjugate([
			[1, 3, 3],
			[1, 4, 3],
			[1, 3, 4]
		])).to.array([
			[7, -3, -3],
			[-1, 1, 0],
			[-1, 0, 1]
		])
	}) // }}}

	it('cofactor 2x2', func() { // {{{
		expect(Matrix.cofactor([
			[0, 1],
			[1, 2]
		])).to.eql([
			[2, -1],
 			[-1, 0]
		])
	}) // }}}

	it('cofactor 3x3', func() { // {{{
		expect(Matrix.cofactor([
			[1, 3, 3],
			[1, 4, 3],
			[1, 3, 4]
		])).to.array([
			[7, -1, -1],
			[-3, 1, 0],
			[-3, 0, 1]
		])
	}) // }}}

	it('cofactor 4x4', func() { // {{{
		expect(Matrix.cofactor([
			[1, 4, -1, 0]
			[2, 3, 5, -2]
			[0, 3, 1, 6]
			[3, 0, 2, 1]
		])).to.eql([
			[-60, -74, 78, 24]
			[41, -29, -75, 27]
			[39, -17, -29, -59]
			[-152, 44, 24, -26]
		])
	}) // }}}

	it('determinant 1x1', func() { // {{{
		expect(Matrix.determinant([
			[1]
		])).to.equal(1)
	}) // }}}

	it('determinant 2x2', func() { // {{{
		expect(Matrix.determinant([
			[2, 3],
			[6, 7]
		])).to.equal(-4)
	}) // }}}

	it('determinant 3x3', func() { // {{{
		expect(Matrix.determinant([
			[0, 1, 2],
			[3, 4, 5],
			[6, 7, 8]
		])).to.eql(0)
	}) // }}}

	it('determinant 4x4', func() { // {{{
		expect(Matrix.determinant([
			[1, 4, -1, 0]
			[2, 3, 5, -2]
			[0, 3, 1, 6]
			[3, 0, 2, 1]
		])).to.eql(-434)
	}) // }}}

	it('inverse 2x2', func() { // {{{
		expect(Matrix.inverse([
			[0, 1],
			[1, 2]
		])).to.array([
			[-2, 1],
 			[1, 0]
		])
	}) // }}}

	it('inverse 3x3', func() { // {{{
		expect(Matrix.inverse([
			[1, 3, 3],
			[1, 4, 3],
			[1, 3, 4]
		])).to.array([
			[7, -3, -3],
			[-1, 1, 0],
			[-1, 0, 1]
		])
	}) // }}}

	it('isSquare 2x2', func() { // {{{
		expect(Matrix.isSquare([[1,2],[3,4]])).to.be.true
	}) // }}}

	it('isSquare 3x2', func() { // {{{
		expect(Matrix.isSquare([[1,2,3],[4,5,6]])).to.be.false
	}) // }}}

	it('multiply 3x2 * 2x3', func() { // {{{
		expect(Matrix.multiply(
			[
				[0, 1, 2],
				[3, 4, 5]
			],
			[
				[0, 3],
				[1, 4],
				[2, 5]
			]
		)).to.eql([[5, 14], [14, 50]])
	}) // }}}

	it('multiply 3x2 * 3x1', func() { // {{{
		expect(Matrix.multiply(
			[
				[0, 1, 2],
				[3, 4, 5]
			],
			[
				[0],
				[1],
				[2]
			]
		)).to.eql([[5], [14]])
	}) // }}}

	it('multiply 2x3 * 1', func() { // {{{
		expect(Matrix.multiply(
			[
				[0, 1, 2],
				[3, 4, 5]
			],
			[0, 2, 3]
		)).to.eql([8, 23])
	}) // }}}

	it('multiply 1 * 2x3', func() { // {{{
		expect(Matrix.multiply(
			[0, 2],
			[
				[0, 1, 2],
				[3, 4, 5]
			]
		)).to.eql([6, 8, 10])
	}) // }}}

	it('multiply 3x3 * 1', func() { // {{{
		expect(Matrix.multiply(
			[
				[0, 1, 2],
				[3, 4, 5],
				[6, 7, 8]
			],
			[0, 2, 3]
		)).to.eql([8, 23, 38])
	}) // }}}

	it('multiply 1 * 3x3', func() { // {{{
		expect(Matrix.multiply(
			[0, 2, 3],
			[
				[0, 1, 2],
				[3, 4, 5],
				[6, 7, 8]
			]
		)).to.eql([24, 29, 34])
	}) // }}}

	it('scale 2x2', func() { // {{{
		expect(Matrix.scale([
			[0, 1],
			[1, 2]
		], 5)).to.eql([
			[0, 5],
 			[5, 10]
		])
	}) // }}}

	it('scale 3x3', func() { // {{{
		expect(Matrix.scale([
			[1, 3, 3],
			[1, 4, 3],
			[1, 3, 4]
		], 5)).to.eql([
			[5, 15, 15],
			[5, 20, 15],
			[5, 15, 20]
		])
	}) // }}}

	it('transpose 3x2', func() { // {{{
		expect(Matrix.transpose([
			[0, 1, 2],
			[3, 4, 5]
		])).to.eql([
			[0, 3],
			[1, 4],
			[2, 5]
		])
	}) // }}}
})