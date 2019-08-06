require|import '@zokugun/lang.math.vector'

export namespace Matrix {
	func adjugate(matrix: Array): Array? { // {{{
		if const cof = cofactor(matrix) {
			return transpose(cof)
		}
		else {
			return null
		}
	} // }}}

	func cofactor(matrix: Array): Array? { // {{{
		const rows = matrix.length
		const cols = matrix[0].length

		if rows != cols || rows == 1 {
			return null
		}

		if rows == 2 {
			return [
				[matrix[1][1], -matrix[1][0]]
				[-matrix[0][1], matrix[0][0]]
			]
		}

		const result = new Array(rows)

		for r from 0 til rows {
			result[r] = new Array(cols)

			for c from 0 til cols {
				result[r][c] = minor(matrix, r, c) * (((r + c) % 2) == 1 ? -1 : 1)
			}
		}

		return result
	} // }}}

	func determinant(matrix: Array): Number? { // {{{
		const rows = matrix.length
		const cols = matrix[0].length

		if rows != cols {
			return null
		}
		if rows == 1 {
			return matrix[0][0]
		}
		if rows == 2 {
			const [[a, b], [c, d]] = matrix

			return (a * d) - (b * c)
		}
		if rows == 3 {
			const [[a, b, c], [d, e, f], [g, h, i]] = matrix

			return (
				(a * e * i) +
				(b * f * g) +
				(c * d * h) -
				(c * e * g) -
				(b * d * i) -
				(a * f * h)
			)
		}

		return matrix[0]
			.map((value, i) => value * minor(matrix, 0, i) * (i % 2 ? -1 : 1))
			.reduce((x, y) => x + y)
	} // }}}

	func minor(matrix: Array, rowIndex, colIndex) // {{{
		=> determinant(
			matrix.filter(
				(row, index) => index != rowIndex
			)
			.map(
				row => row.filter(
					(col, index) => index != colIndex
				)
			)
		)
	// }}}

	func multiply(matrixA: Array, matrixB: Array): Array? { // {{{
		if matrixA[0] is Array {
			if matrixA[0].length == matrixB.length {
				const result = new Array(matrixA.length)

				if matrixB[0] is Array {
					const l = matrixB[0].length

					for x from 0 til matrixA.length {
 						result[x] = new Array(l)
					}

					const transB = transpose(matrixB)

					for i from 0 til result.length {
						for j from 0 til result[i].length {
							result[i][j] = Vector.dot(matrixA[i], transB[j])
						}
					}
				}
				else {
					for i from 0 til result.length {
						result[i] = Vector.dot(matrixA[i], matrixB)
					}
				}

				return result
			}
			else {
				return null
			}
		}
		else if matrixA.length == matrixB.length {
			const transB = transpose(matrixB)
			const result = new Array(transB.length)

			for i from 0 til result.length {
				result[i] = Vector.dot(transB[i], matrixA)
			}

			return result
		}
		else {
			return null
		}
	} // }}}

	func inverse(matrix: Array): Array? { // {{{
		if const d = determinant(matrix) {
			return scale(adjugate(matrix) as Array, 1 / d)
		}
		else {
			return null
		}
	} // }}}

	func isSquare(matrix: Array): Boolean => matrix.length == matrix[0].length

	func transpose(matrix: Array): Array { // {{{
		const result = new Array(matrix[0].length)
		const length = matrix.length

		for i from 0 til matrix[0].length {
			result[i] = new Array(length)

			for j from 0 til length {
				result[i][j] = matrix[j][i]
			}
		}

		return result
	} // }}}

	func scale(matrix: Array, scalar: Number): Array => matrix.map(row => row.map(val => val * scalar))

	export {
		adjugate
		cofactor
		determinant
		minor
		multiply
		inverse
		isSquare
		scale
		transpose
	}
}