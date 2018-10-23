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
	| board spaces |
	spaces := { NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new }.
	self
		should: [ board := Board playedBy: #('hector' 'ignacio') composedBy: spaces ]
		raise: AssertionFailure
		withExceptionDo:[ :signal | self assert: signal messageText equals: 'Add more spaces!' ]
	
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithAnInvalidQuantityOfSpaces [
	| board |
	self
		should: [ board := Board playedBy: #('hector' 'ignacio') spaces: 101 ]
		raise: AssertionFailure
		withExceptionDo:[ :signal | self assert: signal messageText equals: 'Spaces Quantity must be a multiple of 100' ]
	
]

{ #category : #tests }
BoardTest >> testAPlayerCanMoveOnTheBoardAndIsTheTopPlayer [
	| board spaces |
	spaces := BoardTest createNoEffectSpacesCollection.	
	board := Board playedBy: #('hector' 'ignacio') composedBy: spaces.
	board move: 'hector' by: 5.
	self assert: board playerPositions topPlayer equals: 'hector'.
	self assert:( board playerPositions positionOf: 'hector') equals: 6
]

{ #category : #tests }
BoardTest >> testAPlayerCanMoveToANegativeLapAndMoreThanOneLap [
	| board spaces |
	spaces := BoardTest createNoEffectSpacesCollection.	
	self assert: spaces size equals: 8.
	board := Board playedBy: #('hector' 'ignacio') composedBy: spaces.
	self assert: (board playerPositions positionOf: 'hector') equals: 1 .
	board move: 'hector' by: -1.
	self assert:( board playerPositions positionOf: 'hector') equals: 8;
		  assert:( board playerPositions lapsOf: 'hector') equals: -1.
	board move: 'hector' by: 8.
	self assert:( board playerPositions positionOf: 'hector') equals: 8;
	     assert:( board playerPositions lapsOf: 'hector') equals: 0.
	board move: 'hector'  by: 10.
	self assert:( board playerPositions positionOf: 'hector') equals: 2;
	     assert:( board playerPositions lapsOf: 'hector') equals: 2.
]

{ #category : #tests }
BoardTest >> testCanMoveAllPlayersExceptOneOfThem [
	| board spaces |
	spaces := BoardTest createNoEffectSpacesCollection.	
	self assert: spaces size equals: 8.
	board := Board playedBy: #('hector' 'ignacio' 'juan') composedBy: spaces.
	self assert: (board playerPositions positionOf: 'hector') equals: 1 ;
		  assert: (board playerPositions positionOf: 'ignacio') equals: 1 ;
		  assert: (board playerPositions positionOf: 'juan') equals: 1 ;
		  assert:( board playerPositions lapsOf: 'hector') equals: 0;
		  assert:( board playerPositions lapsOf: 'ignacio') equals: 0;
		  assert:( board playerPositions lapsOf: 'juan') equals: 0.
		  
	board moveAllExcept: 'hector' by: 8. 
	
	self assert:( board playerPositions positionOf: 'ignacio') equals: 1;
		  assert:( board playerPositions lapsOf: 'ignacio') equals: 1;
		  assert:( board playerPositions positionOf: 'juan') equals: 1;
		  assert:( board playerPositions lapsOf: 'juan') equals: 1.
]

{ #category : #tests }
BoardTest >> testCanMoveAllPlayersToInitialPositionButTheyKeepTheLaps [
	| board spaces |
	spaces := BoardTest createNoEffectSpacesCollection.	
	self assert: spaces size equals: 8.
	board := Board playedBy: #('hector' 'ignacio' 'juan') composedBy: spaces.
	
	self assert: (board playerPositions positionOf: 'hector') equals: 1 ;
		  assert: (board playerPositions positionOf: 'ignacio') equals: 1 ;
		  assert: (board playerPositions positionOf: 'juan') equals: 1 ;
		  assert:( board playerPositions lapsOf: 'hector') equals: 0;
		  assert:( board playerPositions lapsOf: 'ignacio') equals: 0;
		  assert:( board playerPositions lapsOf: 'juan') equals: 0.
		  
	board move: 'hector' by: 10;
			move: 'juan' by: 10;
			move: 'ignacio' by: 10. 
	
	self assert:( board playerPositions positionOf: 'hector') equals: 3;
		  assert:( board playerPositions lapsOf: 'hector') equals: 1;
		  assert:( board playerPositions positionOf: 'ignacio') equals: 3;
		  assert:( board playerPositions lapsOf: 'ignacio') equals: 1;
		  assert:( board playerPositions positionOf: 'juan') equals: 3;
		  assert:( board playerPositions lapsOf: 'juan') equals: 1.
		
	board moveAllToInitialPosition.
	
	self assert:( board playerPositions positionOf: 'hector') equals: 1;
		  assert:( board playerPositions lapsOf: 'hector') equals: 1;
		  assert:( board playerPositions positionOf: 'ignacio') equals: 1;
		  assert:( board playerPositions lapsOf: 'ignacio') equals: 1;
		  assert:( board playerPositions positionOf: 'juan') equals: 1;
		  assert:( board playerPositions lapsOf: 'juan') equals: 1.
]