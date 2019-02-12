Class {
	#name : #CardsTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsTests >> testAccelerationCardAffectsAllPlayers [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces deck |
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	deck := Deck
		composedBy:
			{AccelerationCard new.
			AccelerationCard new.
			AccelerationCard new.
			AccelerationCard new} asOrderedCollection.
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	spaces := BoardTest createNoEffectSpacesCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 3.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: (playerOne myCards first) in: game.
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 6
]

{ #category : #tests }
CardsTests >> testCancellationCanBeDoneIfAtLeast1PermanentCardIsActive [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card cancellationCard deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	cancellationCard := CancellationCard new.
	card := SpeedCard new.
	deck := Deck composedBy: {card.AccelerationCard new.cancellationCard .AccelerationCard new} asOrderedCollection.
	spaces := BoardTest createNoEffectSpacesCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self
		should: [ playerTwo play: cancellationCard  in: game cancelling: card ]
			raise: AssertionFailure
			withExceptionDo: [ :signal | self assert: signal messageText equals: 'Cannot play Cancellation when not active cards available' ];
		assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 3.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: card in: game affecting: playerTwo.
	playerTwo play: cancellationCard  in: game cancelling: card.
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 5.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 7
]

{ #category : #tests }
CardsTests >> testCancellationCanBeDoneOnlyWithTheRightCard [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces acellerationCard speedUpCard deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := BoardTest createNoEffectSpacesCollection.
	acellerationCard := AccelerationCard new.
	speedUpCard := SpeedCard new.
	deck := Deck
		composedBy:
			{acellerationCard.
			AccelerationCard new.
			speedUpCard.
			AccelerationCard new} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: acellerationCard in: game.
	game move: playerOne.
	self
		assert: (game gameStatus positionOf: playerOne) equals: 4;
		assert: (game hasTheTurn: playerTwo);
		should: [ playerTwo play: speedUpCard in: game cancelling: acellerationCard ]
			raise: AssertionFailure
			withExceptionDo:
				[ :signal | self assert: signal messageText equals: 'Only Cancellation Card can cancel other card' ].
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 4
]

{ #category : #tests }
CardsTests >> testCancellationCardAffectsAnotherCard [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card cancellationCard deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := BoardTest createNoEffectSpacesCollection.
	card := SpeedCard new.
	cancellationCard := CancellationCard new.
	deck := Deck
		composedBy:
			{card.
			AccelerationCard new.
			cancellationCard.
			AccelerationCard new} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 3.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: card in: game affecting: playerTwo.
	playerTwo play: cancellationCard in: game cancelling: card.
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 5.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 7
]

{ #category : #tests }
CardsTests >> testOverloadCardAffectsAPlayer [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := BoardTest createNoEffectSpacesCollection.
	card := OverloadCard new.
	deck := Deck
		composedBy:
			{card.
			AccelerationCard new.
			AccelerationCard new.
			AccelerationCard new} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 3.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: card in: game affecting: playerTwo.
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 5.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 5
]

{ #category : #tests }
CardsTests >> testPermanentCardCanBeUsedOnlyOnPlayerTurn [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card otherCard deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := BoardTest createNoEffectSpacesCollection.
	card := SpeedCard new.
	otherCard := AccelerationCard new.
	deck := Deck
		composedBy:
			{card.
			otherCard.
			AccelerationCard new.
			AccelerationCard new} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self
		assert: (game gameStatus positionOf: playerOne) equals: 3;
		assert: (game hasTheTurn: playerTwo);
		should: [ playerOne play: card in: game affecting: playerTwo ]
			raise: AssertionFailure
			withExceptionDo: [ :signal | self assert: signal messageText equals: 'You cannot play now' ].
	self
		assert: (game gameStatus positionOf: playerOne) equals: 3;
		assert: (game hasTheTurn: playerTwo);
		should: [ playerOne play: otherCard in: game affecting: playerTwo ]
			raise: AssertionFailure
			withExceptionDo: [ :signal | self assert: signal messageText equals: 'You cannot play now' ]
]

{ #category : #tests }
CardsTests >> testRedoAccelerationCard [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card redoCard deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := BoardTest createNoEffectSpacesCollection.
	redoCard := RedoCard new.
	card := AccelerationCard new.
	deck := Deck
		composedBy:
			{card.
			redoCard.
			AccelerationCard new.
			AccelerationCard new} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 3.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: card in: game.
	game move: playerOne.
	playerOne play: redoCard in: game.
	self assert: (game gameStatus positionOf: playerOne) equals: 6.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 1
]

{ #category : #tests }
CardsTests >> testRedoCancellationCard [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces cancellingCard redoCard speedCard overloadCard deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := {BoardTest createNoEffectSpacesCollection.
	SpeedUpSpace new} flattened.
	redoCard := RedoCard new.
	speedCard := SpeedCard new.
	cancellingCard := CancellationCard new.
	overloadCard := OverloadCard new.
	deck := Deck
		composedBy:
			{redoCard.
			speedCard.
			cancellingCard.
			overloadCard} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: speedCard in: game affecting: playerTwo.
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	self assert: (game hasTheTurn: playerTwo).
	playerTwo play: overloadCard in: game affecting: playerOne.
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 4.
	self assert: (game hasTheTurn: playerOne).
	playerTwo play: cancellingCard in: game cancelling: speedCard.
	game move: playerOne.
	playerOne play: redoCard in: game cancelling: overloadCard.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 8.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 6
]

{ #category : #tests }
CardsTests >> testRedoOnlyCanBeUsedIfAnotherCardWasPlayed [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces redoCard deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := BoardTest createNoEffectSpacesCollection.
	redoCard := RedoCard new.
	deck := Deck composedBy: {redoCard.AccelerationCard new.AccelerationCard new.AccelerationCard new}asOrderedCollection .
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self
		should: [ playerOne play: redoCard in: game affecting: playerTwo ]
		raise: AssertionFailure
		withExceptionDo:
			[ :signal | self assert: signal messageText equals: 'Redo only can be used if a Card was Used' ]
]

{ #category : #tests }
CardsTests >> testRedoOveloadCard [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card redoCard deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := BoardTest createNoEffectSpacesCollection.
	redoCard := RedoCard new.
	card := OverloadCard new.
	deck := Deck
		composedBy:
			{redoCard.
			card.
			AccelerationCard new.
			AccelerationCard new} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 3.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: playerOne myCards first in: game affecting: playerTwo.
	game move: playerOne.
	playerOne play: playerOne myCards first in: game affecting: playerTwo.
	self assert: (game gameStatus positionOf: playerOne) equals: 5.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 3
]

{ #category : #tests }
CardsTests >> testRedoRedoAccelerationCard [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card redoCard anotherRedo deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := BoardTest createNoEffectSpacesCollection.
	redoCard := RedoCard new.
	anotherRedo := RedoCard new.
	card := AccelerationCard new.
	deck := Deck
		composedBy:
			{card.
			AccelerationCard new.
			redoCard.
			anotherRedo} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: card in: game.
	playerTwo play: redoCard in: game.
	playerTwo play: anotherRedo in: game.
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 6
]

{ #category : #tests }
CardsTests >> testRedoRedoRepeatCard [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card redoCard anotherRedoCard deck |
	sequenceOne := CircularIterator contains: #(7 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := {BoardTest createNoEffectSpacesCollection.
	SpeedUpSpace new} flattened.
	redoCard := RedoCard new.
	anotherRedoCard := RedoCard new.
	card := RepeatCard new.
	deck := Deck composedBy: { card.redoCard.anotherRedoCard.AccelerationCard new }asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 4.
	playerOne play: card in: game affecting: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 8.
	playerOne play: redoCard in: game affecting: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	playerTwo play:anotherRedoCard in:game affecting: playerOne .
	self assert: (game gameStatus positionOf: playerOne) equals: 7.
	
]

{ #category : #tests }
CardsTests >> testRedoRepeatCard [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card redoCard deck |
	sequenceOne := CircularIterator contains: #(7 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := {BoardTest createNoEffectSpacesCollection.
	SpeedUpSpace new} flattened.
	redoCard := RedoCard new.
	card := RepeatCard new.
	deck := Deck
		composedBy:
			{card.
			redoCard.
			AccelerationCard new.
			AccelerationCard new} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 4.
	playerOne play: card in: game affecting: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 8.
	playerOne play: redoCard in: game affecting: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3
]

{ #category : #tests }
CardsTests >> testRedoSpeedCard [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card redoCard deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := BoardTest createNoEffectSpacesCollection.
	redoCard := RedoCard new.
	card := SpeedCard new.
	deck := Deck
		composedBy:
			{card.
			redoCard.
			AccelerationCard new.
			AccelerationCard new} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 3.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: card in: game affecting: playerTwo.
	game move: playerOne.
	playerOne play: redoCard in: game affecting: playerTwo.
	self assert: (game gameStatus positionOf: playerOne) equals: 5.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 1
]

{ #category : #tests }
CardsTests >> testRepeatCardAffectsAPlayer [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card deck |
	sequenceOne := CircularIterator contains: #(7 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := {BoardTest createNoEffectSpacesCollection.
	SpeedUpSpace new} flattened.
	card := RepeatCard new.
	deck := Deck composedBy: {(AccelerationCard new).(AccelerationCard new).card.(AccelerationCard new)} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 4.
	playerTwo play: card in: game affecting: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 8
]

{ #category : #tests }
CardsTests >> testRepeatCardAffectsAPlayerOnlyIfSpaceHasAnEffect [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := {BoardTest createNoEffectSpacesCollection.
	SpeedUpSpace new} flattened.
	card := RepeatCard new.
	deck := Deck composedBy: { (AccelerationCard new).(AccelerationCard new).card.(AccelerationCard new) }asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	playerTwo play: card in: game affecting: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3
	
]

{ #category : #tests }
CardsTests >> testRepeatCardOnlyAffectsAPlayerIfDicesWereRolled [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card deck |
	sequenceOne := CircularIterator contains: #(7 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := {BoardTest createNoEffectSpacesCollection.
	SpeedUpSpace new} flattened.
	card := RepeatCard new.
	deck := Deck
		composedBy:
			{card.
			AccelerationCard new.
			AccelerationCard new.
			AccelerationCard new} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	playerOne play: card in: game affecting: playerTwo.
	self assert: (game gameStatus positionOf: playerOne) equals: 4.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 3
]

{ #category : #tests }
CardsTests >> testSpeedCardAffectsAPlayer [
	| game playerOne playerTwo sequenceOne sequenceTwo diceOne diceTwo spaces card deck |
	sequenceOne := CircularIterator contains: #(1 1 1 2 1 5 3 1 6).
	sequenceTwo := CircularIterator contains: #(1 1 1 2 2 4 1 1 6).
	diceOne := Dice faces: 10 ofType: (DeterministicType rolling: sequenceOne faces: 10).
	diceTwo := Dice faces: 12 ofType: (DeterministicType rolling: sequenceTwo faces: 12).
	playerOne := Player named: 'Carrot'.
	playerTwo := Player named: 'Nacho'.
	spaces := BoardTest createNoEffectSpacesCollection.
	card := SpeedCard new.
	deck := Deck composedBy: {card.(AccelerationCard new).(AccelerationCard new).(AccelerationCard new)} asOrderedCollection.
	game := Game
		playedBy:
			{playerOne.
			playerTwo}
		throwing:
			{diceOne.
			diceTwo}
		boardComposedBy: spaces
		totalLaps: 2
		using: deck.
	self assert: (game hasTheTurn: playerOne).
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 3.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 3.
	self assert: (game hasTheTurn: playerOne).
	playerOne play: card in: game affecting: playerTwo.
	game move: playerOne.
	self assert: (game gameStatus positionOf: playerOne) equals: 5.
	self assert: (game hasTheTurn: playerTwo).
	game move: playerTwo.
	self assert: (game gameStatus positionOf: playerTwo) equals: 8
]
