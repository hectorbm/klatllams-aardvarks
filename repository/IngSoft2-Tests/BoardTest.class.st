Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #creator }
BoardTest class >> createNoEffectSpacesCollection [
	| spaces |
	spaces:=OrderedCollection new.
	spaces add: (NoEffectSpace new) withOccurrences: 8.
	^spaces
]

{ #category : #tests }
BoardTest >> testABoardCannotBeComposedByLessThanSixSpaces [
	| board spaces deck |
	deck := Deck composedByCardsQuantity: 10.
	spaces := { NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new }.
	self
		should: [ board := Board playedBy: #('hector' 'ignacio') composedBy: spaces using: deck]
		raise: AssertionFailure
		withExceptionDo:[ :signal | self assert: signal messageText equals: 'Add more spaces!' ]
	
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithAnInvalidQuantityOfSpaces [
	| board deck |
	deck := Deck composedByCardsQuantity: 10.
	self
		should: [ board := Board playedBy: #('hector' 'ignacio') spaces: 9 using: deck ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'You need more spaces' ]
]

{ #category : #tests }
BoardTest >> testAPlayerCanMoveOnTheBoardAndIsTheTopPlayer [
	| board spaces deck |
	deck := Deck composedByCardsQuantity: 10.
	spaces := BoardTest createNoEffectSpacesCollection.
	board := Board playedBy: #('hector' 'ignacio') composedBy: spaces using: deck.
	board calculateAndUpdate: 'hector' by: 5.
	self assert: board gameStatus topPlayer equals: 'hector'.
	self assert: (board gameStatus positionOf: 'hector') equals: 6
]

{ #category : #tests }
BoardTest >> testAPlayerCanMoveToANegativeLapAndMoreThanOneLap [
	| board spaces deck |
	deck := Deck composedByCardsQuantity: 10.
	spaces := BoardTest createNoEffectSpacesCollection.
	self assert: spaces size equals: 8.
	board := Board playedBy: #('hector' 'ignacio') composedBy: spaces using: deck.
	self assert: (board gameStatus positionOf: 'hector') equals: 1.
	board calculateAndUpdate: 'hector' by: -1.
	self
		assert: (board gameStatus positionOf: 'hector') equals: 8;
		assert: (board gameStatus lapsOf: 'hector') equals: -1.
	board calculateAndUpdate: 'hector' by: 8.
	self
		assert: (board gameStatus positionOf: 'hector') equals: 8;
		assert: (board gameStatus lapsOf: 'hector') equals: 0.
	board calculateAndUpdate: 'hector' by: 10.
	self
		assert: (board gameStatus positionOf: 'hector') equals: 2;
		assert: (board gameStatus lapsOf: 'hector') equals: 2
]
