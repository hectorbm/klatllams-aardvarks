Class {
	#name : #BoardSpacesTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardSpacesTest >> testAMoonWalkSpaceCanHaveABackwardsValueRandom [
	self assert: ((1 to: 10) includes: MoonWalkSpace generateValidBackwardsValue).
]

{ #category : #tests }
BoardSpacesTest >> testAMoonWalkSpaceCannotHaveABackwardsValueLessThan1OrMoreThan10 [
	self
		should: [ MoonWalkSpace backwardsValue: 0 ] raise: AssertionFailure;
		should: [ MoonWalkSpace backwardsValue: 11 ] raise: AssertionFailure
]

{ #category : #tests }
BoardSpacesTest >> testAMoonWalkSpaceWithBackwardsValue4MovesPlayerBackwardsBy4 [
	| board spaces deck |
	deck := Deck composedByCardsQuantity: 10.
	spaces := {NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	(MoonWalkSpace backwardsValue: 4)}.
	board := Board playedBy: #('hector' 'ignacio') composedBy: spaces using: deck.
	board moveAndAffect: 'hector' by: 4.
	board moveAndAffect: 'ignacio' by: 5.
	self assert: (board gameStatus positionOf: 'hector') equals: 1
]

{ #category : #tests }
BoardSpacesTest >> testANoEffectSpaceCannotChangeAPlayerPosition [
	| board spaces deck |
	deck := Deck composedByCardsQuantity: 10.
	spaces := BoardTest createNoEffectSpacesCollection.
	board := Board playedBy: #('hector' 'ignacio') composedBy: spaces using: deck.
	board moveAndAffect: 'hector' by: 5.
	self assert: (board gameStatus positionOf: 'hector') equals: 6
]

{ #category : #tests }
BoardSpacesTest >> testAtomicBombSpaceAndMoveEveryOneToInitialPosition [
	| board spaces deck |
	deck := Deck composedByCardsQuantity: 10.
	spaces := {NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	AtomicBombSpace new}.
	board := Board playedBy:#('hector' 'ignacio') composedBy:spaces using:deck.
	board moveAndAffect: 'hector' by: 4.
	board moveAndAffect: 'ignacio' by: 5.
	self
		assert: (board gameStatus positionOf: 'hector') equals: 1;
		assert: (board gameStatus positionOf: 'ignacio') equals: 1
]

{ #category : #tests }
BoardSpacesTest >> testCardSpaceAssignsACardToAPlayer [
	| spaces players board card deck|
	card:= AccelerationCard new.
	deck := Deck composedBy:{card}asOrderedCollection.
	spaces := {CardSpace new.
	CardSpace new.
	CardSpace new.
	CardSpace new.
	CardSpace new.
	CardSpace new} asOrderedCollection.
	players := { Player named:'Carrot' . Player named:'Nacho'} asOrderedCollection .
	board := Board playedBy: players composedBy: spaces using: deck.
	card updateOwner: (players second).
	board deck addAnActive:(CardPlayerAffected withCard: card affecting: players ).
	board deck removeAnActive: card.
	(spaces first) affect: players first on: board.
	card := (players first) myCards first.
	self assert: (card owner) equals: (players first)
	
]

{ #category : #tests }
BoardSpacesTest >> testSpeedUpHoleSpaceAndMoveAPlayerForwardsBy4 [
	| board spaces deck |
	deck := Deck composedByCardsQuantity: 10.
	spaces := {NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	SpeedUpSpace new}.
	board := Board playedBy:#('hector' 'ignacio') composedBy:spaces using:deck.
	board moveAndAffect: 'hector' by: 4.
	board moveAndAffect: 'ignacio' by: 5.
	self
		assert: (board gameStatus positionOf: 'hector') equals: 5;
		assert: (board gameStatus positionOf: 'ignacio') equals: 4
]

{ #category : #tests }
BoardSpacesTest >> testWormHoleSpaceAndMoveAPlayerBackwardsBy4 [
	| board spaces deck |
	deck := Deck composedByCardsQuantity: 10.
	spaces := {NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	NoEffectSpace new.
	WormHoleSpace new}.
	board := Board playedBy:#('hector' 'ignacio') composedBy:spaces using:deck.
	board moveAndAffect: 'hector' by: 4.
	board moveAndAffect: 'ignacio' by: 5.
	self
		assert: (board gameStatus positionOf: 'hector') equals: 5;
		assert: (board gameStatus positionOf: 'ignacio') equals: 2
]
