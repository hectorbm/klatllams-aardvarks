"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".
For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'availableCards',
		'validCards',
		'removedCards',
		'activeCardsPlayerAffected'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Deck class >> assertValidCardsQuantity: aQuantity [
	aQuantity < 10
		ifTrue:[AssertionFailure signal:'Must have more than 10 cards']
]

{ #category : #'instance creation' }
Deck class >> composedBy: aCardsCollection [
	^self new initializeWithCards: aCardsCollection.
]

{ #category : #'instance creation' }
Deck class >> composedByCardsQuantity: aQuantity [
	| cards |
	self assertValidCardsQuantity: aQuantity .
	cards := self generateACardsQuantity: aQuantity.
	^self new initializeWithCards: cards.
]

{ #category : #generators }
Deck class >> generateACardsDistribution [
	| distribution |
	distribution := OrderedCollection new.
	distribution addAll: ((1 to: 10) collect: [ :n | AccelerationCard new ]).
	distribution addAll: ((1 to: 10) collect: [ :n | CancellationCard new ]).
	distribution addAll: ((1 to: 10) collect: [ :n | OverloadCard new ]).
	distribution addAll: ((1 to: 10) collect: [ :n | RedoCard new ]).
	distribution addAll: ((1 to: 10) collect: [ :n | RepeatCard new ]).
	distribution addAll: ((1 to: 10) collect: [ :n | SpeedCard new ]).
	distribution shuffled.
	^ distribution
]

{ #category : #generators }
Deck class >> generateACardsQuantity: aQuantity [
	| distribution cards randomSpace |
	distribution := self generateACardsDistribution.
	cards := OrderedCollection new.
	aQuantity
		timesRepeat: [ randomSpace := distribution at: 60 atRandom.
			cards add: randomSpace ].
	^ cards
]

{ #category : #accessing }
Deck >> activeCardsPlayerAffected [
	^ activeCardsPlayerAffected
]

{ #category : #updating }
Deck >> addAnActive: aCardPlayerAffected [
	self assertIsAValid: aCardPlayerAffected card.
	activeCardsPlayerAffected add: aCardPlayerAffected
]

{ #category : #updating }
Deck >> addToRemovedCards: aCard [
	self assertIsAValid: aCard.
	removedCards add: aCard
]

{ #category : #asserting }
Deck >> assertIsAValid: aCard [
	validCards detect: [ :card | card = aCard ] ifNone: [ AssertionFailure signal: 'Not a valid card' ]
]

{ #category : #asserting }
Deck >> assertNotEmptyAvailableCards [
	availableCards
		ifEmpty: [ availableCards addAll: removedCards shuffled.
			removedCards removeAll ]
]

{ #category : #action }
Deck >> deliverNewCard [
	| card |
	self assertNotEmptyAvailableCards.
	card := availableCards first.
	availableCards remove: card.
	^ card
]

{ #category : #initialization }
Deck >> initializeWithCards: aCardsCollection [
	availableCards := aCardsCollection.
	validCards := aCardsCollection.
	removedCards := OrderedCollection new.
	activeCardsPlayerAffected := OrderedCollection new.
]

{ #category : #updating }
Deck >> removeAnActive: card [
	activeCardsPlayerAffected
		detect: [ :cardPlayerAffected | cardPlayerAffected card = card ]
		ifFound: [ :cardPlayerAffected | 
			activeCardsPlayerAffected remove: cardPlayerAffected.
			self addToRemovedCards: cardPlayerAffected card ]
]

{ #category : #accessing }
Deck >> removedCards [
	^ removedCards
]
