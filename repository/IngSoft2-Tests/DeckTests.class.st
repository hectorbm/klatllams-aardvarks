Class {
	#name : #DeckTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckTests >> testADeckCanBeCreatedComposedByCards [
	| deck cards card1 |
	card1 := CancellationCard new.
	cards := {card1.
	AccelerationCard new.
	SpeedCard new} asOrderedCollection.
	deck := Deck composedBy: cards.
	self
		assert: deck activeCardsPlayerAffected isEmpty;
		assert: deck deliverNewCard equals: card1;
		assert: deck activeCardsPlayerAffected isEmpty.
	deck addAnActive: (CardPlayerAffected withCard: card1 affecting: 'john').
	self assert: deck activeCardsPlayerAffected size equals: 1;
			assert: deck removedCards isEmpty.
	deck removeAnActive: card1.
	self
		assert: deck activeCardsPlayerAffected isEmpty;
		assert: deck removedCards size equals: 1.
]

{ #category : #tests }
DeckTests >> testADeckCanBeCreatedWithADistribution [
	| deck |
	deck := Deck composedByCardsQuantity: 10.
	self
		should: [ Deck composedByCardsQuantity: 9 ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Must have more than 10 cards' ]
]

{ #category : #tests }
DeckTests >> testADeckCreatesAUniformDistributionOfCards [
	| distribution cards|
	distribution := Deck generateACardsDistribution.
	self assert: distribution size equals: 60.
	cards := Deck generateACardsQuantity: 5.
	self assert: cards size equals: 5.
]

{ #category : #tests }
DeckTests >> testAnInvalidCardCannotBeUsedOnADeck [
	| deck cards card1 |
	card1 := AccelerationCard new.
	cards := {AccelerationCard new.
	SpeedCard new} asOrderedCollection.
	deck := Deck composedBy: cards.
	self
		should: [ deck addAnActive: (CardPlayerAffected withCard: card1 affecting: 'john') ]
			raise: AssertionFailure
			withExceptionDo: [ :signal | self assert: signal messageText equals: 'Not a valid card' ];
		should: [ deck addToRemovedCards: card1 ]
			raise: AssertionFailure
			withExceptionDo: [ :signal | self assert: signal messageText equals: 'Not a valid card' ]
]
