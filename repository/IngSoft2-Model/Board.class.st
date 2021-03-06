"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	playerPositions:		<Object>
	spaces:		<Object>


    Implementation Points
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'deck',
		'spaces',
		'gameStatus',
		'landingPlayerPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> assertMinimumQuantityOf: aSpacesCollection [
	aSpacesCollection size < 6
		ifTrue:[AssertionFailure signal:'Add more spaces!']
]

{ #category : #'instance creation' }
Board class >> assertValidSpacesQuantity: aQuantity [
	aQuantity < 10
		ifTrue: [ AssertionFailure signal: 'You need more spaces' ]
]

{ #category : #generators }
Board class >> generateDistribution [
	| distribution |
	distribution := OrderedCollection new.
	distribution add: AtomicBombSpace new withOccurrences: 2 asFloat floor.
	distribution
		addAll: ((1 to: 10) collect: [ :n | MoonWalkSpace backwardsRandom ]).
	distribution add: NoEffectSpace new withOccurrences: 38.
	distribution add: SpeedUpSpace new withOccurrences: 20.
	distribution add: WormHoleSpace new withOccurrences: 20.
	distribution add: CardSpace new withOccurrences: 10.
	distribution shuffled.
	^ distribution
]

{ #category : #generators }
Board class >> generateRandomSpaceDistributionWith: aQuantity [
	| distribution randomDistribution randomSpace |
	distribution := self generateDistribution.
	randomDistribution := OrderedCollection new.
	aQuantity
		timesRepeat: [ randomSpace := distribution at: 100 atRandom.
			randomDistribution add: randomSpace ].
	^ randomDistribution
]

{ #category : #'instance creation' }
Board class >> playedBy: aPlayersCollection composedBy: aSpacesCollection using: aDeck [
	self assertMinimumQuantityOf: aSpacesCollection .
	^ self new initializePlayedBy: aPlayersCollection composedBy: aSpacesCollection using: aDeck
]

{ #category : #'instance creation' }
Board class >> playedBy: aPlayersCollection spaces: aQuantity using: aDeck [
	| spacesCollection |
	self assertValidSpacesQuantity: aQuantity.
	spacesCollection := self generateRandomSpaceDistributionWith: aQuantity.
	^ self new initializePlayedBy: aPlayersCollection composedBy: spacesCollection using: aDeck
]

{ #category : #updating }
Board >> calculateAndUpdate: aPlayer by: aQuantity [
	| positionsCircularIter |
	positionsCircularIter := CircularIterator
		contains: (1 to: spaces size) asOrderedCollection
		startingAt: (gameStatus positionOf: aPlayer).
	gameStatus
		updatePositionAndLapsOf: aPlayer
		to: (positionsCircularIter nextBy: aQuantity)
		adding: positionsCircularIter turns + (gameStatus lapsOf: aPlayer)
]

{ #category : #accessing }
Board >> deck [
	^ deck
]

{ #category : #accessing }
Board >> gameStatus [
	^ gameStatus
]

{ #category : #initialization }
Board >> initializePlayedBy: aPlayersCollection composedBy: aSpacesCollection using: aDeck [
	spaces := aSpacesCollection.
	gameStatus := GameStatus players: aPlayersCollection.
	landingPlayerPositions := OrderedCollection new.
	deck := aDeck

	
]

{ #category : #accessing }
Board >> lastLandingPositionOf: aPlayer [
	landingPlayerPositions
		detect: [ :landingPosition | landingPosition player = aPlayer ]
		ifFound: [ :landingPosition | ^ landingPosition position ]
		ifNone: [ ^0 ]
]

{ #category : #action }
Board >> moveAndAffect: aPlayer by: aValue [
	deck activeCardsPlayerAffected
		select: [ :cardPlayerAffected | cardPlayerAffected isAffecting: aPlayer ]
		thenDo:
			[ :cardPlayerAffected | cardPlayerAffected card affect: aPlayer on: self ].
	self calculateAndUpdate: aPlayer by: aValue.
	self
		updateLastLandingOf: aPlayer
		to: (gameStatus positionOf: aPlayer).
	(spaces at: (gameStatus positionOf: aPlayer))
		affect: aPlayer
		on: self
]

{ #category : #accessing }
Board >> spaces [
	^ spaces
]

{ #category : #updating }
Board >> updateLastLandingOf: aPlayer to: aPosition [
	| newLandingPosition |
	newLandingPosition := LandingPosition player: aPlayer on: aPosition.
	landingPlayerPositions addFirst: newLandingPosition
]
